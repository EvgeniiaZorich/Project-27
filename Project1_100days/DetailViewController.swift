//
//  DetailViewController.swift
//  Project1_100days
//
//  Created by user226947 on 12/8/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var ImageView: UIImageView!
    var selectedImage: String?
    var currentPos: Int?
    var total: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if let selectedImageUW = selectedImage else print("Missing name.")}
        
        let selectedImageUW = selectedImage ?? ""
        let currentPosUW = currentPos ?? 0
        let totalUW = total ?? 0
        
        title = selectedImageUW + "; image \(currentPosUW) of \(totalUW)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            let image = UIImage(named: imageToLoad)
            
            let imageNew = drawImagesAndText(width: image?.size.width ?? 100, height: image?.size.height ?? 200, image: image!)
            ImageView.image = imageNew
        }

    }
    
    func drawImagesAndText(width: CGFloat, height: CGFloat, image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))

        let img = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40),
                .paragraphStyle: paragraphStyle
            ]

            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(with: CGRect(x: 30, y: 30, width: width, height: 100), options: .usesLineFragmentOrigin, context: nil)

            
        }

        return img
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
        
    }
    
    @objc func shareTapped() {
        guard let image = ImageView.image?.jpegData(compressionQuality: 0.8)  else {
            print("No image")
            return
        }
        
        var imageArray: [Any] = [image]
        if let imageText = selectedImage {
            imageArray.append(imageText)
        }

        let vc = UIActivityViewController(activityItems: imageArray, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem  = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
}

