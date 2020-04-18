import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// to Array
/*
 영상에는 Observable인데 swift 5.0부터는 Single로 바뀐듯
 completed가 된 시점 까지의 데이터를 배열로 만듬
 */
//Observable.of(1,2,3,4,5)
//    .toArray()
//    .subscribe(onSuccess: {
//        print($0)
//    })
//// [1, 2, 3, 4, 5]
//
//// map
///*
// swift에서 사용하는것과 같다. 다만 다른 것은 observable로 작동한다는 것.
// */
//Observable.of(1,2,3,4,5)
//    .map {
//        return $0 * 2 // return 을 표기 안해줘도 되긴 함 그냥 명시적 표현인건가?
//}.subscribe(onNext: {
//    print($0)
//}).disposed(by: disposeBag)

// flatMap
struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()

student.asObservable()
    .debug("debug")
//    .flatMap { $0.score.asObservable() }
    .flatMapLatest { $0.score.asObservable() }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

student.onNext(john)
john.score.accept(100)
student.onNext(mary)
john.score.accept(90)
/*
 75
 100
 95
 90
 */
