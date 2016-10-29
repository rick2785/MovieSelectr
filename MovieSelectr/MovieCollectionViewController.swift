//
//  MovieCollectionViewController.swift
//  MovieSelector
//
//  Created by Rickey Hrabowskie on 10/23/16.
//  Copyright © 2016 Rickey Hrabowskie. All rights reserved.
//

import UIKit
import MovieSelectrBridge

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {

    var nowPlaying = [Movie]()
    var selectedMovieByPeak:Movie?
    
    //let movieTransitionDelegate = MovieTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: collectionView!)
        }

        
    }
    
    func loadData(){
        Movie.nowPlaying { (success:Bool, movieList:[Movie]?) in
            
            if success {
                self.nowPlaying = movieList!
                DispatchQueue.main.async {
                    self.collectionView!.reloadData()
                }
            }
            
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return nowPlaying.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
    
        let movie = nowPlaying[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        
        Movie.getImage(forCell: cell, withMovieObject: movie)
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
            let movieObject = nowPlaying[indexPath.row]
            
            if segue.identifier == "showDetail" {
                let detailVC = segue.destination as! MovieDetailViewController
                detailVC.movieObject = movieObject
            }
            
        }
    }
    
    
    // PEEK
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location),
            let cell = collectionView?.cellForItem(at: indexPath) else {return nil}
        
        previewingContext.sourceRect = cell.frame
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let overlayVC = sb.instantiateViewController(withIdentifier: "Overlay") as! OverlayViewController
        
        overlayVC.preferredContentSize = CGSize(width: 0, height: 200)
        
        selectedMovieByPeak = nowPlaying[indexPath.row]
        overlayVC.movieItem = selectedMovieByPeak
        
        return overlayVC
        
    }
    
    //POP
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let movieDetailVC = sb.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailViewController
        
        if let availableMovie = selectedMovieByPeak {
            movieDetailVC.movieObject = availableMovie
            show(movieDetailVC, sender: self)
        }
        
    }
    
    
    
    
    /*override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showOverlayFor(indexPath: indexPath)
    }
    
    
    
    func showOverlayFor (indexPath:IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let overlayVC = sb.instantiateViewController(withIdentifier: "Overlay") as! OverlayViewController
        
        transitioningDelegate = movieTransitionDelegate
        overlayVC.transitioningDelegate = movieTransitionDelegate
        overlayVC.modalPresentationStyle = .custom
        
        let movie = nowPlaying[indexPath.row]
        
        self.present(overlayVC, animated: true, completion: nil)
        overlayVC.movieItem = movie
        
    
    
    }*/
    
    
}




