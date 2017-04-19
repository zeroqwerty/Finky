//
//  LoadingTableViewCell.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 19.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

// Ячейка для строки с сообщением о загрузке и индикатором загрузки
class LoadingTableViewCell: UITableViewCell {
    
    /// Индикатор загрузки
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.stopAnimating()
    }
    
}
