//
//  main.swift
//  bmutil
//
//  Created by Masayuki Nii on 2014/07/27.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation

func bmutilProcessing()-> Int32 {
    let params = CommandLine("c:r:")
    let paramsArray: Array<String> = params.opts
    
    if params.undefinedOpts.count > 0   {
        print("Unsupported parameter is passed. Process aborted.")
        return 3
    }
    
    let fm: FileManager = FileManager.default
    let bookmarks: Data
    
    if paramsArray.firstIndex(of: "c") != nil  {
        if ((params.parameters["c"] != nil) && params.targets.count == 2) {
            if fm.fileExists(atPath: params.targets[1])   {
                let targetURL: URL = URL(fileURLWithPath: params.targets[1])
                do {
                    bookmarks = try targetURL.bookmarkData(options: [.suitableForBookmarkFile,.minimalBookmark],
                                                           includingResourceValuesForKeys: [],
                                                           relativeTo: nil)
                } catch {
                    print("Error in generate bookmark data.")
                    return 4
                }
                let createURL: URL = URL(fileURLWithPath:params.parameters["c"]!)
                do {
                    try URL.writeBookmarkData(bookmarks, to: createURL)
                } catch {
                    print("Error in writing to the alias file.")
                    return 8
                }
            } else {
                print("Target file doesn't exist: \(params.targets[1])")
                return 6
            }
        } else {
            print("Parameter error.")
            return 7
        }
    } else if paramsArray.firstIndex(of: "r") != nil   {
        if ((params.parameters["r"]) != nil) {
            if fm.fileExists(atPath: params.parameters["r"]!)   {
                do {
                    let fileURL = try URL(resolvingAliasFileAt: URL(fileURLWithPath: params.parameters["r"]!),
                                          options: [.withoutUI , .withoutMounting])
                    print(fileURL.path)
                    return 0
                } catch {
                    print("Error in resolving alias file.")
                    return 9
                }
            } else {
                print("The specified file doesn't exist.")
                return 10
            }
        } else {
            print("Parameter error.")
            return 11
        }
    }
    return 0
}

exit(bmutilProcessing())


