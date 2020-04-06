import UIKit
import RxSwift
import PlaygroundSupport


let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

//// ignore
///*
// .next event는 무시한다.
// .error이나 .complete는 전달한다.(종료되는 시점만 알 수 있음)
// */
//
//strikes
//    .ignoreElements()
//    .subscribe { _ in
//    print("[Subsscription is called]")
//}.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//
//strikes.onCompleted()
//// onCompleted를 하니까 프린트가 된다.
//// [Subsscription is called]

// -------------

//// element at
///*
// 발생하는 이벤트 중 n번째 이벤트만 받고싶을 때 사용한다.
// */
//strikes
//    .elementAt(2)
//    .subscribe(onNext: { value in
//        print("You are out! -> \(value)")
//    }).disposed(by: disposeBag)
//
//strikes.onNext("a")
//strikes.onNext("b")
//strikes.onNext("c")
//// You are out! -> c

//// filter
///*
// 조건에 맞는 값만 필터링하는 것
// */
//Observable
//    .of(1,2,3,4,5,6,7)
//    .filter { $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//// skip
///*
// 처음 발생하는 n개의 이벤트를 무시할 수 있다.
// */
//Observable
//    .of("A","B","C","D","E","F")
//    .skip(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//// skip While
///*
// filter와 기능이 유사하다.
// filter는 통과 된 element를 전달하지만,
// skipWhile은 통과되지 못한 element를 전달한다.
// */
//Observable
//    .of(2,2,3,4,4)
//    .skipWhile { $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//// skip Until
///*
// trigger가 되는 시퀀스에서 이벤트가 발생하기 전까지 모든 이벤트가 skip된다.
// */
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.skipUntil(trigger)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//
//trigger.onNext("X")
//
//subject.onNext("C")

//// take
///*
// 처음 발생하는 n개의 이벤트만 받고 나머지는 무시
// */
//Observable
//    .of(1,2,3,4,5,6)
//    .take(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//// take While
///*
// skip While과 유사
// 검사가 통과된 이벤트는 전달한다.
// 만약 통과하지 못한 이벤트가 있다면 그 이벤트와 이후 이벤트 모두 무시된다.
// */
//Observable
//    .of(2,4,6,8,9,10)
//    .takeWhile { $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

// take Until
/*
 skip Until과 유사
 trigger에 이벤트가 발생하면 이후 이벤트 모두 무시
 */
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject
    .takeUntil(trigger)
    .subscribe(onNext: {
    print($0)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")
trigger.onNext("X")
subject.onNext("3")

