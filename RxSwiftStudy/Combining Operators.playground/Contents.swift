import UIKit
import RxSwift

// startsWith
/*
 Observable 시퀀스 앖에 다른 값 하나를 추가해준다.
 */
let disposeBag = DisposeBag()

//let numbers = Observable.of(2,3,4)
//
//let observable = numbers.startWith(1)
//
//observable.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)

//// concat
///*
// startWith와 비슷하다.
// startWith는 하나의 요소가 맨 앞에 추가되지만,
// concat은 여러개의 요소가 앞 뒤로 추가 가능하다.
// */
//let first = Observable.of(1,2,3)
//let second = Observable.of(4,5,6)
//
//let observable2 = Observable.concat([first, second])
//
//observable2.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)
//
//// +) concatMap -> flatMap & concat이 합쳐진 것으로 순서가 보장된다. (나중에 다시 한번 알아보자)

//// merge
///*
// 시퀀스를 합쳐주는 operator
// merge하고 있는 여러 시퀀스들을 동시에 subscribe하면서 먼저 오는 이벤트들을 바로 전달시켜준다(선착순)
// 최대 몇개까지의 시퀀스를 합칠 것인지 정할 수 있다
// 내부 시퀀스가 종료되면 merge 시퀀스도 종료된다
// 내부 시퀀스가 complete되는 시점은 모두 독립적이다
// 만약 내부 시퀀스에서 error가 방출하면 merge 시퀀스도 에러를 방출시키면 종료된다
// */
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
///*
// 두 개의 시퀀스를 하나의 시퀀스로 합쳐준다
// 서브 시퀀스(두 개의 시퀀스)에서 이벤트가 방출할 때 마다 이벤트를 방출시킨다
// 서브 이벤트에서 최초 이벤트가 방출해야지만 합쳐진 시퀀스에서 이벤트가 방출한다
// zip과의 차이도 알아두자
// combinlatest에서는 최초 이벤트 방출 후 각 서브 시퀀스에서 값이 들어올 때 마다 이벤트를 방출시켰지만
// zip에서는 최초 이벤트 방출 후 각 서브시퀀스에서 새로운 이벤트가 방출 해야지만 이벤트가 방출한다
//
// */
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

//// withLastFrom
///*
// 특정 트리거가 방출 했을 때 특정 상태의 최신 값을 얻고 싶을 때 사용한다
// */
//let button = PublishSubject<Void>()
//let textField = PublishSubject<String>()
//
////let observable = button.withLatestFrom(textField)
//let observable = textField.sample(button)       // sample을 사용하는 경우, 중복된 값이 들어올 경우 이벤트를 방출시키지 않음 -> withLatestFrom + distinctUntilChanged
//let disposable = observable.subscribe(onNext: {
//    print($0)
//})
//
//textField.onNext("Sw")
//textField.onNext("Swif")
//textField.onNext("Swift")
//textField.onNext("Swift Rocks!")
//button.onNext(())
//button.onNext(())

// reduce
/*
 모든 이벤트를 더한 값을 방출
 */
//let source = Observable.of(1,2,3)
//
//source.reduce(0, accumulator: +)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//source.reduce(0, accumulator: { summary, newValue in
//    return summary + newValue
//}).subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)

// scan
/*
 하나씩 더할때 마다 증가된 값을 방출
 */
//let source = Observable.of(1,2,3,4,5,6)
//
//source.scan(0, accumulator: +)
//.subscribe(onNext: {
//    print($0)
//    }).disposed(by: disposeBag)
