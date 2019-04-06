//
//  Utils.swift
//  CustomerSaveForm
//
//  Created by Sravan on 04/04/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import Foundation

extension NSObject {
    
    public func DLog(object: Any, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        #if DEBUG
        let className = (fileName as NSString).lastPathComponent
        print("<\(className)> \(functionName) [#\(lineNumber)]| \(object)")
        #endif
    }
}
