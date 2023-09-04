//
//  HeadsLinesVC.swift
//  newsApp
//
//  Created by Pankaj Sawale on 03/09/23.
//

import UIKit

class HeadsLinesVC: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    var articleData = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        guard let Url = URL(string:"https://newsapi.org/v2/everything?q=apple&from=2023-09-02&to=2023-09-02&sortBy=popularity&apiKey=66159d3f7dc04367af63fcb677aae5bb") else {
            return
        }
        let task = URLSession.shared.dataTask(with: Url, completionHandler: {
            (data, response, error) in
            guard let data = data, error == nil else
            {
                print("Error in parsing Data")
                return
            }
            var news:newsData?
            do
            {
                news = try JSONDecoder().decode(newsData.self, from: data)
                print("Json Responseeeeeb \(news)")
                
            }
            catch
            {
                print("ERROR hjkhh\(error)")
            }
            self.articleData = news!.articles
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        })
        
        task.resume()
    }
    
}

extension HeadsLinesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = articleData[indexPath.item]
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "HeadLinesCell") as! HeadLinesTableViewCell
        cell.newsImg.layer.cornerRadius = 10
        if data.source.name != nil {
            cell.nameLbl.text = data.source.name
        } else {
            cell.nameLbl.text = "NA"
        }
        
        if data.title != nil {
            cell.titleLbl.text = data.title
        } else {
            cell.titleLbl.text = "NA"
        }
        
        if data.publishedAt?.get() != nil {
            if let date = data.publishedAt?.get() {
                cell.dateLbl.text = date.description
            } else {
                cell.dateLbl.text = ""
            }
        } else {
            cell.dateLbl.text = "NA"
        }
        
        
        if data.urlToImage != nil {
            let url = URL(string: data.urlToImage!)
            cell.newsImg.loadImage(from: url!)
        } else {
            cell.newsImg.image = UIImage(named: "emptyImg")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "description") as? DescriptionVC
        vc?.descriptions = articleData[indexPath.row]
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true)
    }
    
    
}
extension UIImageView {
    func loadImage(from url:URL){
        contentMode = .scaleToFill
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        task.resume()
    }
}
extension String {
    func get() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
