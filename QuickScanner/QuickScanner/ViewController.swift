//
//  ViewController.swift
//  QuickScanner
//
//  Created by Cédric Bahirwe on 06/04/2021.
//

import UIKit
import VisionKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViews: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didPressScanButton(_ sender: Any) {
        configureDocumentView()
    }
    
    func configureDocumentView() {
        let scanningDocVc = VNDocumentCameraViewController()
        scanningDocVc.delegate = self
        self.present(scanningDocVc, animated: true, completion: nil)
    }
}


extension ViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: pageNumber)
            
            imageViews.image = image
            print(image)
        }
        dismiss(animated: true, completion: nil)
    }
}
