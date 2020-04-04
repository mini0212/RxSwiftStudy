//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by Hailey on 2020/03/31.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setNavBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController,
            let photoVC = navVC.viewControllers.first as? PhotosCollectionViewController else {
                fatalError("Segue destination is not found")
        }
        
        photoVC.selectedPhoto
            .subscribe(onNext: { [weak self] photo in
            guard let self = self else { return }
//            self.photoView.image = photo
            
            // UI가 바뀌는 것이니 메인스레드에서 작업해주자
            DispatchQueue.main.async {
                self.updateUI(with: photo)
            }
            }).disposed(by: disposeBag)
    }
}

extension ViewController {
    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateUI(with image: UIImage) {
        self.photoView.image = image
        self.filterButton.isHidden = false
    }
    
    @IBAction func touchFilterButton(_ sender: UIButton) {
        guard let sourceImg = self.photoView.image else { return }
//        FilterService().applyFilter(to: sourceImg) { [weak self] filterImage in
//            guard let self = self else { return }
//            self.photoView.image = filterImage
//        }
        
        // 1. 가져온 이미지에
        // 2. 필터를 먹이고
        // 3. UI에 바인드 시킨다.
        FilterService().applyFilter(to: sourceImg)
            .subscribe(onNext: { [weak self] filteredImage in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.photoView.image = filteredImage
                }
            }).disposed(by: disposeBag)
    }
}

