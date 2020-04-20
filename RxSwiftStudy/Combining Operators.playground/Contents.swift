import UIKit
import RxSwift

// startsWith
let disposeBag = DisposeBag()

//let numbers = Observable.of(2,3,4)
//
//let observable = numbers.startWith(1)
//
//observable.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)

//// concat
//let first = Observable.of(1,2,3)
//let second = Observable.of(4,5,6)
//
//let observable2 = Observable.concat([first,second])
//
//observable2.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)

//// merge
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//let source = Observable.of(left.asObservable(), right.asObservable())
//let observable = source.merge()
//observable.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)
//
//left.onNext(5)
//left.onNext(3)
//right.onNext(2)
//right.onNext(1)
//left.onNext(99)

//// combineLatest
//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()
//
//let observable = Observable.combineLatest(left, right, resultSelector: { lastLeft, lastRight in
//    "\(lastLeft) \(lastRight)"
//})
//
//let disposable = observable.subscribe(onNext: { value in
//    print(value)
//    })
//
//left.onNext(5)
//left.onNext(3)
//right.onNext(2)
//right.onNext(1)
//left.onNext(99)

//// with last from
//let button = PublishSubject<Void>()
//let textField = PublishSubject<String>()
//
//let observalbe = button.withLatestFrom(textField)
//let disposable = observalbe.subscribe(onNext: {
//    print($0)
//})
//
//textField.onNext("Sw")
//textField.onNext("Swif")
//textField.onNext("Swift")
//textField.onNext("Swift Rocks!")
//
//button.onNext(())
//button.onNext(())

//// reduce
//let source = Observable.of(1,2,3)
//
//source.reduce(0, accumulator: +)
//.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)
//
//source.reduce(0, accumulator: { summary, newValue in
//    return summary + newValue
//    }).subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

// scan
let source = Observable.of(1,2,3,4,5,6)

source.scan(0, accumulator: +)
.subscribe(onNext: {
    print($0)
    }).disposed(by: disposeBag)
