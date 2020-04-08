//
//  PhotosCollectionViewController.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/02.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import Photos
import RxSwift

private let reuseIdentifier = "PhotoCollectionViewCell"

class PhotosCollectionViewController: UICollectionViewController {

    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var images: [PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
        requestPhotoAuth()
    }
}

extension PhotosCollectionViewController {
    
    private func requestPhotoAuth() {
        // 선생님은 weak self의 중요성을 강조하셨다,,
        // Retain되지 않도록..!
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            if status == .authorized {
                
                let asset = PHAsset.fetchAssets(with: .image, options: nil)
                asset.enumerateObjects { (object, count, stop) in
                    self.images.append(object)
                }
                
                self.images.reverse()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                print("Not authorized")
            }
        }
    }
}

extension PhotosCollectionViewController {
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell Not found")
        }
    
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()
    
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 300, height: 300),
                             contentMode: .aspectFit,
                             options: nil) { image, _ in
                                DispatchQueue.main.async {
                                    cell.photoView.image = image
                                }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset,
                                              targetSize: CGSize(width: 300, height: 300),
                                              contentMode: .aspectFit,
                                              options: nil) { [weak self] image, info in
                                                guard let self = self,
                                                    let info = info else { return }
                                                // 화질구지로 받아오기
                                                let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
                                                if !isDegradedImage {
                                                    if let image = image {
                                                        self.selectedPhotoSubject.onNext(image)
                                                        self.dismiss(animated: true, completion: nil)
                                                    }
                                                }
        }
    }
}
