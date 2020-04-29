# rmdupe
Simple tool created by IgnorantGuru: https://igurublog.wordpress.com/downloads/script-rmdupe/.

rmdupe uses standard Linux commands to search within specified folders for duplicate files, regardless of filename or extension. Before duplicate candidates are removed they are compared byte-for-byte. rmdupe can also check duplicates against one or more reference folders, can trash files instead of removing them, allows for a custom removal command, and can limit its search to files of specified size. rmdupe includes a simulation mode which reports what will be done for a given command without actually removing any files.

```
rmdupe --help

Usage: rmdupe [OPTIONS] FOLDER [...]
Removes duplicate files in specified folders.  By default, newest duplicates
 are removed.
Options:
-R, -r              search specified folders recursively
--ref FOLDER        also search FOLDER recursively for copies but don't
                    remove any files from here (multiple --ref allowed)
                    Note: files may be removed from a ref folder if that
                    folder is also a specified folder
--trash FOLDER      copy duplicate files to FOLDER instead of removing
--sim               simulate and report duplicates only - no removal
--quiet             minimize output (disabled if used with --sim)
--verbose           detailed output
--old               remove oldest duplicates instead of newest
--minsize SIZE      limit search to duplicate files SIZE MB and larger
--maxsize SIZE      limit search to duplicate files SIZE MB and smaller
--rmcmd "RMCMD"     execute RMCMD instead of rm to remove copies
                    (may contain arguments, eg: "rm -f" or "shred -u")
--xdev              don't descend to other filesystems when recursing
                    specified or ref folders
Notes: do not use wildcards; symlinks are not followed except on the
       command line; zero-length files are ignored
```

Anytime ––sim is included anywhere on the command line, rmdupe goes into simulation mode which only reports, doesn’t remove. This can be used to see what files a given command will remove, or can simply be used to search for duplicates.

Examples of usage:

```
# remove dupes in /user/test but not subfolders
rmdupe /user/test

# remove dupes from /user/test and subfolders
rmdupe -r /user/test

# remove dupes from /user/test1 and /user/test2 and subfolders
rmdupe -r /user/test1 /user/test2

# trash dupes from /user/test
rmdupe --trash /user/trash /user/test

# only remove dupes larger than 50MB
rmdupe --minsize 50 /user/test

# shred dupes before removing
rmdupe --rmcmd "shred -u" /user/test

# remove dupes from /user/test using /user/keep as a reference
rmdupe -r /user/test --ref /user/keep
```

rmdupe will always remove the newest duplicates, preserving the oldest copy of a file, unless the ––old option is used, which reverses this.

All specified folders are searched as a group. When rmdupe is finished, they will collectively contain only one copy of each file.

Reference folders are folders you want checked against for duplicates, but not cleared of duplicates. For example, if copies of file “A” in specified folders exist in a reference folder, the copies in the specified folders will be removed. The copy in the reference folder is never removed unless the reference folder is also specified on the command line as a non-reference folder. The reference folder method is used to check for duplicates against a collection of files which you don’t want removed. You may specify more than one reference folder with multiple ––ref options. Reference folders are always searched recursively.

Note that rmdupe may take some time if there are large numbers of files of exactly the same size. If files are the same size, this triggers rmdupe to do a byte-by-byte compare (cmp) on the files.

The ––trash option allows specification of a trash folder to be used. Each duplicate is moved to the trash folder, using a unique filename if needed. If a move to the trash folder fails, rmdupe halts with an error.

Normally rmdupe only reports files it’s removing. For more detailed feedback as it’s running, use the ––verbose option.
