//
//  GPXActivityItemSource.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 06/07/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation
import UIKit

class GPXActivityItemSource: NSObject, UIActivityItemSource {
    let data: Data
    let title: String
    
    init(with title: String, and data: Data) {
        self.data = data
        self.title = title
        super.init()
    }
    
    @available(iOS 6.0, *)
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return data
    }
    
    @available(iOS 6.0, *)
    func activityViewController(_ activityViewController: UIActivityViewController,
                                itemForActivityType activityType: UIActivityType?) -> Any? {
        return data
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController,
                                subjectForActivityType activityType: UIActivityType?) -> String {
        return title
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController,
                                dataTypeIdentifierForActivityType activityType: UIActivityType?) -> String {
        return "com.topografix.gpx"
    }
}
