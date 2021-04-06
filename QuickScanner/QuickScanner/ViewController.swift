//
//  ViewController.swift
//  QuickScanner
//
//  Created by Cédric Bahirwe on 06/04/2021.
//

import UIKit
import VisionKit

class ViewController: UIViewController {

    var selectedImages: [UIImage] = []
    var currentIndex = 0
    @IBOutlet weak var imageViews: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
    }


    @IBAction func didPressScanButton(_ sender: Any) {
        configureDocumentView()
    }
    
    func configureDocumentView() {
        let scanningDocVc = VNDocumentCameraViewController()
        scanningDocVc.delegate = self
        self.present(scanningDocVc, animated: true, completion: nil)
    }
    
    func addTapGesture() {
        
        let tagpGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageViews.isUserInteractionEnabled = true
        imageViews.addGestureRecognizer(tagpGesture)
    }
    
    @objc func didTap() {
        if !selectedImages.isEmpty {
            
            if currentIndex < selectedImages.count-1 {
                currentIndex += 1
            } else {
                currentIndex = 0
            }
            imageViews.image = selectedImages[currentIndex]

        }
    }
}


extension ViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            
            selectedImages.append(image)
        }
        imageViews.image = selectedImages.first
        addTapGesture()
        dismiss(animated: true, completion: nil)
    }
}
