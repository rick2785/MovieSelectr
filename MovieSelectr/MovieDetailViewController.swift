//
//  MovieDetailViewController.swift
//  MovieSelector
//
//  Created by Rickey Hrabowskie on 10/23/16.
//  Copyright © 2016 Rickey Hrabowskie. All rights reserved.
//

import UIKit
import MovieSelectrBridge

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var movieImageview: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    var movieObject:Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    
    func configureView(){
        movieTitleLabel.text = movieObject.title
        movieDescriptionTextView.text = movieObject.description
        
        if let availableImage = Movie.getImage(forMovie: movieObject) {
        
            movieImageview.image = availableImage
    
        }
    }

}
