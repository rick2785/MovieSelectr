//
//  OverlayViewController.swift
//  MovieSelector
//
//  Created by Rickey Hrabowskie on 10/23/16.
//  Copyright © 2016 Rickey Hrabowskie. All rights reserved.
//

import UIKit
import MovieSelectrBridge

class OverlayViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var movieItem:Movie!
    
    func configureView(){
        if let movie = self.movieItem {
            self.titleLabel.text = movie.title
            self.descriptionTextView.text = movie.description
        }
    }
    
    
   /* override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 200)
        
        self.view.layer.cornerRadius = 5
        
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    
    
    /*@IBAction func closePressed(_ sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
