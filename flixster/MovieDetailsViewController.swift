//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Sam Gustafsson on 2/16/21.
//  Copyright © 2021 Sam Gustafsson. All rights reserved.
//

import UIKit
import AlamofireImage
import WebKit



class MovieDetailsViewController: UIViewController, UICollectionViewDelegate, WKUIDelegate {
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var webView: WKWebView!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "http://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        guard let backDropPath = movie["backdrop_path"] as? String else {
            print("no backdrop path for movie: \(movie["title"])")
            return
        }
        
        //let backDropPath = movie["backdrop_path"] as! String
        let backDropUrl = URL(string: "http://image.tmdb.org/t/p/w780" + backDropPath)
            
        backDropView.af_setImage(withURL: backDropUrl!)
        
        
    }
    

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
    }
    
*/
}
