#bmutil

by Masayuki Nii

The command line utility for the bookmark file in OS X.

##Usage:
```
bmutil -c newFile targetFile*
```
It creates new bookmark file refering to the path "targetFile" at the path "newFile".
(This feature doesn't work so far.)

```
bmutil -r targetFile*
```
It returns the path that refferd by the path "targetFile"