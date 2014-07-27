//
//  main.swift
//  bmutil
//
//  Created by 新居雅行 on 2014/07/27.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation

func bmutilProcessing()-> Int32 {
    let params = CommandLine("c:r:v")
    let paramsArray: NSArray = params.opts
    var vMode: Bool = false
    
    if params.undefinedOpts.count > 0   {
        println("Unsupported parameter is paased. Process aborted.")
        return 3
    }
    
    if paramsArray.indexOfObject("v") != NSNotFound   {
        vMode = true
    }
    
    let error: NSErrorPointer = nil
    var optionsReolve = NSURLBookmarkResolutionOptions(0)
    var optionsCreate : NSURLBookmarkFileCreationOptions = NSURLBookmarkFileCreationOptions(0)
    let fm: NSFileManager = NSFileManager.defaultManager()
    
    if paramsArray.indexOfObject("c") != NSNotFound   {
        if (params.parameters["c"] && params.parameters["c"] && params.targets.count == 2) {
            
            if fm.fileExistsAtPath(params.targets[1])   {
                let targetURL: NSURL = NSURL.fileURLWithPath(params.targets[1])
                let bookmark: NSData? = NSURL.bookmarkDataWithContentsOfURL(targetURL, error: error)
                if error    {
                    return 4
                }
                let createURL: NSURL = NSURL.fileURLWithPath(params.parameters["c"])
                let succeed: Bool = NSURL.writeBookmarkData(bookmark,
                    toURL: createURL,
                    options: optionsCreate,
                    error: error)
                if !succeed {
                    return 8
                }
                if error    {
                    return 5
                }
            } else {
                println("Target file doesn't exist: \(params.targets[1])")
                return 6
            }
        } else {
            return 7
        }
    } else if paramsArray.indexOfObject("r") != NSNotFound   {
        if (params.parameters["r"] && params.parameters["r"]) {
            let resolveFile = NSURL.fileURLWithPath(params.parameters["r"])
            if fm.fileExistsAtPath(params.parameters["r"])   {
                let fileURL = NSURL.URLByResolvingAliasFileAtURL(resolveFile,
                    options: optionsReolve,
                    error: error)
                if !error {
                    println(fileURL.path)
                    return 0
                } else {
                    
                }
            } else {
                
            }
        } else {
            
        }
    }
    return -1
}

exit(bmutilProcessing())


