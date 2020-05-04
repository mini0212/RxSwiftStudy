//
//  WeatherViewController.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/25.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class WeatherViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension WeatherViewController {
    func bind() {
        cityNameTextField.rx
            .controlEvent(.editingDidEndOnExit) // 텍스트 에디트가 끝나고 난 후 api call
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { [weak self] city in
                if let city = city {
                    if city.isEmpty {
                        self?.displayWeather(nil)
                    } else {
                        self?.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
        
//        cityNameTextField.rx.value
//        .subscribe(onNext: { city in
//            if let city = city {
//                if city.isEmpty {
//                    self.displayWeather(nil)
//                } else {
//                    self.fetchWeather(by: city)
//                }
//            }
//            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity)"
        } else {
            self.temperatureLabel.text = "😠"
            self.humidityLabel.text = "⚡️"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            //            let url = URL(string: cityEncoded) else { return }
            let url = URL.urlForWeahterAPI(city: cityEncoded) else { return }
        let resource = WeatherResource<WeatherResult>(url: url)
        
        
        
//        let search = URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        let search = URLRequest.load(resource: resource)
            .retry(3) // 재 시도 할 횟수
            .observeOn(MainScheduler.instance)
            .catchError { error in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
        }.asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0.main.temp) ℉"}
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        search.map { "\($0.main.humidity)"}
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
////            .catchErrorJustReturn(WeatherResult.empty)
//
//        search.map { "\($0.main.temp) ℉"}
//            .bind(to: self.temperatureLabel.rx.text)
//            .disposed(by: disposeBag)
//        search.map { "\($0.main.humidity)"}
//            .bind(to: self.humidityLabel.rx.text)
//            .disposed(by: disposeBag)
        
//        URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance) // DispatchQueue를 사용하는 대신 메인스레드에서 하는 것을 알려준다
//            .catchErrorJustReturn(WeatherResult.empty)
//            .subscribe(onNext: { [weak self] result in
//                print(result)
//                let weather = result.main
//                self?.displayWeather(weather)
//            }).disposed(by: disposeBag)
        
    }
}
