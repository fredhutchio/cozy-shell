# cozy-shell

How to be comfortable in the shell.
This will proceed from simple and straightforward uses and configurations to more advanced ones.


## Finding things

With desktop OS's, we are used to being able to see where we are and search easily by filenames and content.
Let's see some linux commands to stay oriented.


### tree
The `tree` command shows the nested directory structure as a tree:
```
.
├── buckle
│   └── shoe
│       └── file.txt
└── one
    └── two
```
This can get pretty lengthy when we have a big directory tree, so we can limit it with `-L`, say in this case `tree -L 2`:
```
.
├── buckle
│   └── shoe
└── one
    └── two
```


### find

[GNU Find](https://www.gnu.org/software/findutils/manual/html_mono/find.html) is an incredibly powerful command.
It is complex enough to get its own [Wikipedia page](https://en.wikipedia.org/wiki/Find), which in fact has a nice collection of examples.

I mostly just use it for a few simple things, illustrated by the following examples:

* `find .`: list all files and directories descending from the current one
* `find some/directory -name "*.py"`: find all files and directories in descending from `some/directory` ending in `.py`
* `find . -name "*nofonts.svg" -exec /bin/rm {} \;`: remove every file ending in `nofonts.svg` contained in the current directory.


### grep

Moving on to finding files by their content, the first step is the classic `grep`.

To find occurrences of the string "smooshable" in any file contained in the current directory, just write

```
grep -R smooshable
```

where the `-R` is for recursive search across the directory tree.

I don't actually use recursive grep much.
If I'm looking for something in a git repository I use `git grep`:

```
git grep smooshable
```

which is tidier because it doesn't find things in the `.git` directory, etc.

If I have a lot of big files to search through, [ag, the silver searcher](https://github.com/ggreer/the_silver_searcher) is a great tool.
It searches recursively by default, so in this example

```
ag smooshable
```

will get you a nicely formatted list of instances.
Note that ag also has lots of nice editor integrations.


## Terminal multiplexing

When working on a modern desktop computer, it's easy to arrange multiple windows side by side, to switch between applications, etc.
On the command line this is achieved by use of a "terminal multiplexer".
This is absolutely essential for working on remote machines.

We've covered this in detail [in our bioinformatics intro class slides](http://fredhutchio.github.io/intro-bioinformatics/01-gestalt.html#/tmux---terminal-multiplexer)
and in an [intro article](http://www.fredhutch.io/articles/2014/04/27/terminal-multiplex/)
so I'm not going to go into detail beyond that.


## History

Your "history" is the list of commands you have entered.
Here are some commands to help you browse that history:
* `history`: gives the full history; likely to be too much too be useful
* `history | tail`: the history truncated to the most recent commands
* `history | less`: history made more navigable

You can also search through your history.
Hitting `Ctrl-r` brings up reverse interactive search.
In this example, I typed `tags`, which brings up the most recent command containing the string `tags`:
```
$ git describe --tags --long
bck-i-search: tags_
```
You can cycle through earlier commands by hitting `Ctrl-r` again.
If you want to cancel your reverse search, use `Ctrl-g`.


## Interacting with the web

To get something off the web, use `wget` and then the web address.
This is handy in combination with the "raw" address for files on GitHub (available as a button on the right hand side of a file's page), e.g.:
```
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
```

Another related tool is [curl](https://curl.haxx.se/docs/manual.html), which is quite powerful.

If you actually have to interact with the web via the command line, you can always use `lynx`.
If you want to watch nyan cat, you can do so by executing `telnet nyancat.dakko.us`.


## Git prompt

I don't mind what shells or editors people in my group use, but I really feel strongly that everyone should use a shell prompt that displays information about git status.
Not having this inevitably leads to confusion with partial commits.

The git folks understand this and have made a [git prompt script](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh).
Bash folks: you can grab this using the wget command above, move it to `/.git-prompt.sh`, and throw this in your `.bashrc`:
```
source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
```

If you use zsh you probably have all of this configured, but I'd suggest trying out [antigen](https://github.com/zsh-users/antigen) which has a plugin system making all this trivial.



## Moving around

We all know and love `cd`, but moving around with raw `cd` can get tedious.
First a few little tricks:

* `cd`: moves you back to your home directory
* `cd -`: moves you back to your previous location

But still, getting deep in a directory tree takes a lot of typing and/or tab completion.
For this reason, I use [autojump](https://github.com/wting/autojump), which remembers where you've been so you can move around more quickly.
Before you install that tool, though, take a look at the next section, which also offers a faster way to navigate deep in directory trees.


## Fuzzy finding

We all love tab completion.
But sometimes it too can be painful.
Consider this list of files, which is the various posts that have appeared on fredhutch.io:

```
2014-04-24-command-line.md                    2014-11-07-intermediate-R.md                2015-08-27-cloud-computing-presentation.md
2014-04-27-terminal-multiplex.md              2014-12-09-hidra.md                         2015-12-02-galaxy-rna-seq.md
2014-05-09-galaxy.md                          2014-12-15-scicomp-unix-hpc.md              2016-01-21-cds-git.md
2014-05-11-editing.md                         2015-02-11-scicomp-unix-hpc.md              2016-02-25-immunespace.md
2014-05-17-git.md                             2015-03-09-introductory-R.md                2016-03-01-i-heart-pandas.md
2014-05-20-R.md                               2015-03-12-rollout-galaxy-101.md            2016-03-28-gizmo-brownbag.md
2014-07-13-toolbox.md                         2015-04-02-april-galaxy-101.md              2016-06-14-scicomp-unix-hpc.md
2014-07-16-aws.md                             2015-04-06-R-sequence-analysis.md           2016-07-28-galaxy-101.md
2014-08-13-synapse.md                         2015-04-23-ucsc-xena-workshop.md            2016-08-23-chipseq-class.md
2014-09-19-R-course.md                        2015-04-24-third-galaxy-101.md              2016-08-31-rnaseq-class.md
2014-10-20-introductory-r-course-material.md  2015-05-04-spring-2015-intermediate-r.md    2016-09-08-illustration-inkscape.md
2014-10-22-shippable.md                       2015-05-20-spring-2015-unix-hpc.md          2016-09-27-intro-r.md
2014-10-27-bioconductor.md                    2015-06-03-summer-bioinformatics-course.md  2016-10-03-introbio.md
2014-11-03-labkey.md                          2015-08-26-data-center-tour.md
```

to tab-complete through these files is a pain, because I actually want to say something about the content, which is past the date.

Thus we can use _fuzzy finding_, which allows us to use arbitrary substrings to find what I want.
This is available [in GitHub](https://github.com/blog/793-introducing-the-file-finder) for finding files, and actually even in the Chrome address bar.
With fuzzy finding, you can just type substrings of your desired string and the matcher will find items that contain those substrings.

For example, if I want the posts from 2015 that contain `galaxy`, I could type `2015galaxy`, and :boom:

```
  2015-03-12-rollout-galaxy-101.md
  2015-04-24-third-galaxy-101.md
  2015-04-02-april-galaxy-101.md
  2014-05-09-galaxy.md
> 2015-12-02-galaxy-rna-seq.md
  5/41
> 2015galaxy
```
we get a list of the files that contain `2015` and `galaxy`.
In fact, I could have typed `15axy` and gotten the same result, because it matches the same set of files.

There are lots of fuzzy finding tools and extensions for editors.
I suggest giving [fzf](https://github.com/junegunn/fzf) a try.
You can do all sorts of fancy things, but to get started the three basic command overrides should be useful:

* `Ctrl-t` finds files
* `Ctrl-r` does reverse search on your history
* `Alt-c` finds and enters directories
