//
//  NotificationName Extension.swift
//  Passeio
//
//  Created by Lucas Cavalcante on 27/06/17.
//  Copyright © 2017 Lucas Cavalcante. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let onEdit: Notification.Name = Notification.Name("passeio.onEdit")
    static let onPlacemarkSet: Notification.Name = Notification.Name("passeio.onPlacemarkSet")
    static let onSettingsChange: Notification.Name = Notification.Name("passeio.onSettingsChange")
}
