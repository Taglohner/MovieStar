//
//  HomeViewController + DataSource.swift
//  MovieStar
//
//  Created by Steven Taglohner on 30/06/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let moviesCategoryAtIndexPath = moviesCategory[indexPath.section]
        
        switch moviesCategoryAtIndexPath.type {
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeViewControllerCell, for: indexPath) as! HomeViewControllerCell
            cell.movies = moviesCategoryAtIndexPath
            cell.homeViewController = self
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moviesCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesCategory[section].rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let moviesCategoryAtIndexPath = moviesCategory[indexPath.section]
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: styleOneHeaderIdentifier, for: indexPath) as! StyleOneHeader
            headerView.title = moviesCategoryAtIndexPath.sectionTitle
            return headerView
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: styleOneFooterIdentifier, for: indexPath) as! StyleOneFooter
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
    }
    
}

