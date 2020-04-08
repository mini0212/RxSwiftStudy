//
//  FilterService.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/04.
//  Copyright © 2020 min_e. All rights reserved.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    // single -> 한번만 호출
    // completable -> 성공 여부만 받음
    func applyFilterSingle(to inputImage: UIImage) -> Single<UIImage> {
        return Single<UIImage>.create { observer -> Disposable in
            self.applyFilter(to: inputImage) { filterImage in
                observer(.success(filterImage))
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to inpuImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inpuImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgImg, scale: inpuImage.scale, orientation: inpuImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}
