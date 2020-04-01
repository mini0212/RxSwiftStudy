import UIKit
import RxSwift 
import RxCocoa
import Pods_RxSwiftStudy

// --- Observable
/*
  Observable -> 관찰 가능한, 관찰할 수 있는
  하나의 sequence(수열)이며, async하다
  Observable이 이벤트를 발생 시키는 것을 emit한다고 표현한다.
 */


// just는 하나의 파라미터를 받아 하나의 이벤트를 발생 시킨다
let observable1 = Observable.just(1) // Observable<Int>

// of는 파라미터의 타입을 전달
let observable2 = Observable.of(1, 2, 3) // Observable<Int>

// of 가 배열이라면 배열 자체를 전달하는 것
let observable3 = Observable.of([1, 2, 3]) // Observable<[Int]>

// from은 배열 타입을 전달받아 배열 안에 있는 요소들을 꺼내 sequence를 생성한다. (array, dictionary, set)
let observable4 = Observable.from([1, 2, 3, 4, 5]) // Observable<Int>

/*
 subscribe()는 addObserver() 대신 사용되는 것이라고 생각하면 된다.
 다른점이라면 NotificationCenter에서는 .default를 이용해 싱글톤을 사용했지만
 Rx에서는 Observable은 subscriber가 없다면 발생한 이벤트를 전송하지 않는다.
 */
observable4.subscribe { event in
//    print(event)
//    if let ele = event.element {
//        print(ele)
//    }
}

/*
 print(event) 일 경우 (optional?)
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 completed
 .next와 .completed 이벤트 발생

 if let ele = event.element {
       print(ele)
 }  일 경우
 1
 2
 3
 4
 5
 엘리멘트로 접근 가능
 */

observable3.subscribe { event in
//    print(event)
//    if let ele = event.element {
//        print(ele)
//    }
}

/*
 print(event) 일 경우 (optional)
 next([1, 2, 3])
 completed

 if let ele = event.element {
     print(ele)
 } 일 경우
 [1, 2, 3]
 */

observable4.subscribe(onNext: { element in
//    print(element)
})
/*
 onNext를 사용하게 되면 next이벤트에 대해서만 프린트해준다.
 따로 바인딩해주지 않아도 됨
1
2
3
4
5
 */


/*
 subscribe()는 Disposable을 리턴한다.
 Observable의 사용이 끝나면 메모리를 해제해야하는데 그때 사용하는 것이 Dispose()
 */
let subscription1 = observable4.subscribe(onNext: { element in
//    print(element)
})

subscription1.dispose()

/*
 DisposeBag은 deinit()이 실행될 때 모든 메모리를 해제한다.
 subscribe가 리턴하는 Disposable 인스턴스를 넣어준다.
 */
let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe {
        print($0)
}.disposed(by: disposeBag)
/*
 next(A)
 next(B)
 next(C)
 completed
 */

/*
 create는 클로저를 사용해 subscribe메서드를 쉽게 구현할 수 있게 한다.
 */
Observable<String>.create { (observer) -> Disposable in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")    // 될까?
    return Disposables.create()
}.subscribe(onNext: {
    print($0)
}, onError: {
    print($0)
}, onCompleted: {
    print("Completed")
}, onDisposed: {
    print("Disposed")
}).disposed(by: disposeBag)
/*
 A
 Completed
 Disposed
 Completed가 되고 난 후에는 next가 호출되지 않는다는 것을 알 수 있다.
 */


// ------- Subject
/*
 Subjectsms Observable을 subscribe(구독)할 수 있고 다시 emit(방출)할 수 있다.
 혹은 새로운 Observable을 emit할 수 있다.
 */
//let disposeBag = DisposeBag()

/*
 PublishSubject는 subscribe전의 이벤트는 emit하지 않고,
 subscribe 이후의 이벤트만 emit
 에러 이벤트가 발행산다면 그 이후 이벤트는 emit하지 않는다.
 */
let subject1 = PublishSubject<String>()
subject1.onNext("First")

subject1.subscribe { event in
    print(event)
}
/*
 이 상황에서는 프린트 되는 것이 없음
 */

subject1.onNext("Second")
subject1.onNext("Third")

subject1.dispose()      // 이벤트가 종료된다.
//subject1.onCompleted()
//subject1.onError(Error.self as! Error)
subject1.onNext("Fourth")
/*
 next(Second)
 next(Third)
 completed
 */

/*
 BehaviorSubject는 PublishSubject와 거의 같지만 BehaviorSubject는 반드시 초기화 해줘야한다.
 */
let subject2 = BehaviorSubject(value: "Initial value")

subject2.onNext("Last Value")
/*
 next(Last Value)
 next(Second value)
 subscribe 되기 전에 값이 onNext되면 Initial vlaue는 사라짐
 */

subject2.subscribe { event in
    print(event)
}
/*
 next(Initial value)
*/

subject2.onNext("Second value")
/*
 next(Initial value)
 next(Second value)
 */

/*
 ReplaySubject는 미리 정해진 사이즈 만큼 가장 최근의 이벤트를 최근의 subscriber에게 전달
 */
let subject3 = ReplaySubject<String>.create(bufferSize: 2)

subject3.onNext("First")
subject3.onNext("Second")
subject3.onNext("Third")

//subject3.subscribe { print($0) }
/*
 next(Second)
 next(Third)
 */

subject3.onNext("Fourth")
subject3.onNext("Fifth")
subject3.onNext("Sixth")

print("- Second subscribe")

//subject3.subscribe { print($0) }
/*
 next(Second)
 next(Third)
 next(Fourth)
 next(Fifth)
 next(Sixth)
 - Second subscribe
 next(Fifth)
 next(Sixth)
 버퍼 사이즈 만큼 마지막 값이 replay
 */

// 'Variable' is deprecated: Variable is deprecated. Please use `BehaviorRelay` as a replacement. 라고 해서 패스
//let subject4 = Variable("Initial Value")


let dispose = DisposeBag()

/*
 error: Couldn't lookup symbols:
 RxRelay.BehaviorRelay.asObservable() -> RxSwift.Observable<A>
 라는 에러가 나서 찾아보니
 https://github.com/ReactiveX/RxSwift/issues/1502
 observer가 아니기 때문에 subject가 아니라고 한다.
 플레이 그라운드에서는 되어주지 않았다,,
 import Pods_RxSwiftStudy 하니까 됨
 
 */
/*
 BehaviorRelay 는 RxCocoa에 포함되어 있다.
 onNext가 아니라 accecpt
 error, complete가 없음(무시..)
 UI에서 에러났다고 화면 안그릴 순 없으니까..
 PublishSubject와 BehaviorSubject를 래핑한 것
 */
let relay = BehaviorRelay(value: "Initial value")

relay.asObservable()
    .subscribe {
//        print($0)
}
// next(Initial value)

let relay2 = BehaviorRelay(value: [String]())

relay2.accept(["Number 1"])

relay2.asObservable()
    .subscribe {
//        print($0)
}
//next(["Number 1"])


let relay3 = BehaviorRelay(value: ["Number 1"])

relay3.accept(["Number 2"])

relay3.asObservable()
    .subscribe {
//        print($0)
}
// next(["Number 2"])


let relay4 = BehaviorRelay(value: ["Number 1"])
var value = relay4.value
value.append("Number 2")
value.append("Number 3")
relay4.accept(value)
// next(["Number 1", "Number 2", "Number 3"])

//relay4.accept(relay4.value + ["Number 2"])

relay4.asObservable()
    .subscribe {
        print($0)
}
// next(["Number 1", "Number 2"])

