//
//  main.swift
//  bmutil
//
//  Created by Masayuki Nii on 2014/07/27.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation

func bmutilProcessing()-> Int32 {
    let params = CommandLine("c:r:v")
    let paramsArray: NSArray = params.opts
    var vMode: Bool = false
    
    if params.undefinedOpts.count > 0   {
        println("Unsupported parameter is passed. Process aborted.")
        return 3
    }
    
    if paramsArray.indexOfObject("v") != NSNotFound   {
        vMode = true
    }
    
    var errorObj: NSError?
    let optionsReolve = NSURLBookmarkResolutionOptions(0)
    let optionsCreate = NSURLBookmarkCreationOptions(1 << 9 | 1 << 10)
    let optionsFile = NSURLBookmarkFileCreationOptions(1 << 9 | 1 << 10)
    let fm: NSFileManager = NSFileManager.defaultManager()
    
    if paramsArray.indexOfObject("c") != NSNotFound   {
        if (params.parameters["c"] && params.targets.count == 2) {
            if fm.fileExistsAtPath(params.targets[1])   {
                let targetURL: NSURL = NSURL.fileURLWithPath(params.targets[1])
                let bookmark: NSData? = targetURL.bookmarkDataWithOptions(
                    optionsCreate,
                    includingResourceValuesForKeys: [],
                    relativeToURL: nil,
                    error: &errorObj)
                if errorObj?    {
                    println(errorObj?.description)
                    return 4
                }
                let createURL: NSURL = NSURL.fileURLWithPath(params.parameters["c"])
                let succeed: Bool = NSURL.writeBookmarkData(
                    bookmark,
                    toURL: createURL,
                    options: optionsFile,
                    error: &errorObj)
                if !succeed {
                    println(errorObj?.description)
                    return 8
                }
                
            } else {
                println("Target file doesn't exist: \(params.targets[1])")
                return 6
            }
        } else {
            println("Parameter error.")
            return 7
        }
    } else if paramsArray.indexOfObject("r") != NSNotFound   {
        if (params.parameters["r"]) {
            let resolveFile = NSURL.fileURLWithPath(params.parameters["r"])
            if fm.fileExistsAtPath(params.parameters["r"])   {
                let fileURL = NSURL.URLByResolvingAliasFileAtURL(
                    resolveFile,
                    options: optionsReolve,
                    error: &errorObj)
                if !errorObj? {
                    println(fileURL.path)
                    return 0
                } else {
                    println(errorObj?.description)
                    return 9
                }
            } else {
                println("The specified file doesn't exist.")
                return 10
            }
        } else {
            println("Parameter error.")
            return 11
        }
    }
    return 0
}

exit(bmutilProcessing())


