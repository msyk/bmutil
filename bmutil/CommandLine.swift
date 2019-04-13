//
//  CommandLine.swift
//  bmutil
//
//  Created by Masayuki Nii on 2014/07/27.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation
class CommandLine   {
    
    public var targets: Array<String> = []
    public var opts: Array<String> = []
    public var undefinedOpts: Array<String> = []
    public var parameters: [String:String] = [:]
    
    init(_ optionArgs: String)    {
        var nextItemParam: Bool = false
        var previousOption: String = ""
        for oneItem in ProcessInfo.processInfo.arguments {
            let itemString: NSString = oneItem as NSString
            if itemString.hasPrefix("-") {
                let indexOptions: String = itemString.substring(from: 1)
                if (optionArgs.range(of: indexOptions + ":") != nil)    {
                    nextItemParam = true
                    previousOption = indexOptions
                    opts = opts + [indexOptions]
                } else if (optionArgs.range(of: indexOptions) != nil)   {
                    opts = opts + [indexOptions]
                } else {
                    undefinedOpts = undefinedOpts + [indexOptions]
                }
            } else if nextItemParam    {
                nextItemParam = false;
                parameters[previousOption] = oneItem
            } else {
                targets = targets + [oneItem]
            }
        }
    }
}

func testCommandLine()  {
    let params = CommandLine("ac:")
    for target in params.targets {
        print("target=\(target)")
    }
    for opt in params.opts {
        if ((params.parameters[opt]) != nil) {
            print("option=\(opt)=\(String(describing: params.parameters[opt]))")
        } else {
            print("option=\(opt)")
        }
    }
    for opt in params.undefinedOpts {
        print("option=\(opt)")
    }
}

