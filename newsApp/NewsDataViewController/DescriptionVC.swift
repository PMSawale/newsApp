//
//  DescriptionVC.swift
//  newsApp
//
//  Created by Pankaj Sawale on 03/09/23.
//

import UIKit

class DescriptionVC: UIViewController {
    
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var descriptions: Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = descriptions?.title
        nameLbl.text = descriptions?.source.name
        
//        dateLbl.text = descriptions?.publishedAt
        if let date = descriptions?.publishedAt?.get() {
            dateLbl.text = date.description
        } else {
            dateLbl.text = ""
        }
        
        descriptionLbl.text = descriptions?.description
        if descriptions?.urlToImage != nil
        {
            let url = URL(string: (descriptions?.urlToImage)!)
            Image.loadImage(from: url!)
        } else {
            Image.image = UIImage(named: "emptyImg")
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
