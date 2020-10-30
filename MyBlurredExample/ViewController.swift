//
//  ViewController.swift
//  MyBlurredExample
//
//  Created by Angelique Babin on 30/10/2020.
//

import UIKit

class ViewController: UIViewController {
        
    private let creditAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 36)
        label.tintColor = UIColor.black
        label.numberOfLines = 0
        label.text = "Photo by Anthony Salerno on Unsplash"
        return label
    }()


    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.frame = view.bounds
        createBlur()
    }
    
    private func createBlur() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        visualEffectView.alpha = 0
        view.addSubview(visualEffectView)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            UIView.animate(withDuration: 0.5) {
                visualEffectView.alpha = 1
                self.view.addSubview(self.creditAuthorLabel)
                self.creditAuthorLabel.frame = self.imageView.bounds
                DispatchQueue.main.asyncAfter(deadline: .now()+10) {
                    let urlAuthor = "https://unsplash.com/@anthony_salerno?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText"
                    self.openSafari(urlString: urlAuthor)
                }
 
            }
        }
    }
    
    private func openSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

