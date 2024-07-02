# Task

## Task (비동기 컨텍스트)
- 비동기 작업을 실행하는 컨테이너(비동기 컨텍스트)   
- Task 블록 내에서 async 함수(비동기 함수)를 await하여 완료될 때까지 대기한다.   
- Task는 반환 값을 가질 수 있으며 await 키워드를 통해 접근할 수 있다.

### 컨텍스트
- 단일 Task 블록은 독립된 실행 컨텍스트에서 실행되며, 이 실행 컨텍스트는 우선순위, 취소 상태 및 로컬 변수와 같은 몇 가지 요소를 포함한다.
- Task는 계층 구조를 가질 수 있으며, 상위(부모) Task는 하위(자식) Task를 포함할 수 있다. 이때 하위 Task는 실행 컨텍스트를 상속받아 사용한다. 
- 이때 컨텍스트에는 우선순위, 취소 상태 등을 상속받는다.
- Task.detached {} 로 부모 Task의 컨텍스트와 분리되어 독립적으로 실행될 수 있다.

### Task Group with for-await
- 여러 개의 비동기 작업을 그룹으로 묶어 관리할 수 있다.
- await withTaskGroup(of: 결과타입.self) {group in }
  - group.addTask {}
  - for await result in group {}

```swift
await withTaskGroup(of: String.self) { group in
    for i in 1...3 {
        group.addTask {
            await fetchData()
        }
    }
    
    for await result in group {
        print("Task group received data: \(result)")
    }
}
```

### about Actor
- 액터 내에서 실행되는 Task(+ 액터의 isolated context를 상속받는 Task): 
  - 액터의 상태에 안전하게 '접근'할 수 있으며, 액터의 상태를 '수정'할 수 있다.
  - 액터의 인스턴스 메서드에 안전하게 접근할 수 있다. 
- 액터 외부에서 실행되는 Task(+ 액터의 isolated context를 상속받지 않는 Task): 
  - 액터의 isolated context를 상속받지 않는다. (상속받을 액터의 컨텍스트가 없음)
  - 액터의 상태에 직접 접근할 수 없으며, 액터의 상태를 안전하게 수정할 수 없다.
  - 액터의 메서드를 호출하려면 해당 호출이 비동기(async)적으로 수행되며, 호출이 완료될 때까지 기다려야 한다.

## 예외 처리

### task.cancel()   
- try Task.sleep 하고 있을 시, 예외 발생
- cancel 되면 Task.checkCancellation 시 예외 발생
- Task.isCancceled is true
    - task(인스턴스)를 cancel하고, 내부 Task 블록에서는 while Task.isCancelled로 (비동기) 작업이 취소되었는지 확인
    - while 블록을 종료시킬 수 있다.

### 비동기 컨텍스트에서의 에러 핸들링
1. Task 블록 내부의 에러
- Task 블록 내부에서 발생한 에러는 해당 블록 외부로 전파되지 않는다.
- task.result(Result<Success, Failure>)에 성공 혹은 에러 결과가 담긴다.
```swift
Task {
    // task.result
    let result = await Task {
        return try await asyncFn()
    }.result

    switch result {
        case .success(let value):
            ...
        case .failure(let error):
            ...
    }
}
```

2. continuation에서의 에러 처리
- withCheckedThrowingContinuation으로 (동기) 블록을 감싼다.
- continuation.resume(with: Result<Success, Failure>) 호출
- Result가 .failure이면, withCheckedThrowingContinuation 블록 밖으로 예외가 throwing 된다.
```swift
func errorHandlingInContinuation() async {
    do {
        try await withCheckedThrowingContinuation { continuation in
            // completion: result -> continuation.resume(with: result)
            syncFn(.., completion: continuation.resume(with:) ) 
        }
    } catch {
        print("error \(error)")
    }
}

func syncFn(.., completion: (Result<Success, Error> -> Void)) {
    completion(.failure(CustomError()))
}
```

continuation: (continuation 인스턴스를 이용해서) 일정시간 대기하다 원하는 타이밍에 작업을 재개(resume)할 수 있는 블록이다.
- 애초부터 async 함수를 await해서 기다리면 되지 않을까? 
- 애초부터 동기 작업이면, await하여 기다릴 수 없음
- 예) boot 작업 시 작업이 완료되면(completion) continuation
- 예) Photo 갤러리에서 사진 선택: 사진이 선택될 때까지 대기하다, 선택이 완료되면 작업 재개
