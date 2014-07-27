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
        var indexTarget: Int = 0
        var indexOptions: Int = 0
        var nextItemParam: Bool = false
        var previousOption: String = ""
        for index in 0..<C_ARGC {
            let oneItem = String.fromCString(C_ARGV[Int(index)])
            let itemString: NSString = oneItem!
            if itemString.hasPrefix("-") {
                let indexOptions: String = itemString.substringFromIndex(1)
                if optionArgs.rangeOfString(indexOptions + ":")    {
                    nextItemParam = true
                    previousOption = indexOptions
                    opts += indexOptions
                } else if optionArgs.rangeOfString(indexOptions)    {
                    opts += indexOptions
                } else {
                    undefinedOpts += indexOptions
                }
            } else if nextItemParam    {
                nextItemParam = false;
                parameters[previousOption] = oneItem!
            } else {
                targets += oneItem!
            }
        }
    }
}

func testCommandLine()  {
    let params = CommandLine("ac:")
    for target in params.targets {
        println("target=\(target)")
    }
    for opt in params.opts {
        if (params.parameters[opt]) {
            println("option=\(opt)=\(params.parameters[opt])")
        } else {
            println("option=\(opt)")
        }
    }
    for opt in params.undefinedOpts {
        println("option=\(opt)")
    }
}

