## Create a temporary file
tmpFile <- paste0(system.file(package = "testPackage"), "/tmp")
tmpFile
file.create(tmpFile)
file.exists(tmpFile)
## Create an external pointer whose finalizer will delete
## the file when the variable is not in used
x <- testPackage:::makeExtPtr(file.remove,tmpFile)
## GC is working fine
rm(list="x")
gc()
file.exists(tmpFile)

## Create the temporary file again
file.create(tmpFile)
file.exists(tmpFile)
x <- testPackage:::makeExtPtr(file.remove,tmpFile)
## Quit R session without explicitly cleaning the working space
quit(save = "no")


##=====Open a new R session=======
## The temporary file still exist 
tmpFile <- paste0(system.file(package = "testPackage"), "/tmp")
file.exists(tmpFile)