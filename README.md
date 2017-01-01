# cozy-shell

How to be comfortable in the shell.
This will proceed from simple and straightforward uses and configurations to more advanced ones.


## Finding things

With desktop OS's, we are used to being able to see where we are and search easily by filenames.
Let's see some linux commands to stay oriented:

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



## History

Your "history" is the list of commands you have entered.
Here are some commands to help you browse that history:
* `history`: gives the full history; likely to be too much too be useful
* `history | tail`: the history truncated to the most recent commands
* `history | less`: history made more navigable

You can also search through your history.
Hitting `Ctrl-R` brings up reverse interactive search.

If you want to cancel your reverse search, use `Ctrl-G`.


## Moving around

We all know and love `cd`, but moving around with raw `cd` can get tedious.
First a few little tricks:

* `cd`: moves you back to your home directory
* `cd -`: moves you back to your previous location


## Advanced topic: fuzzy finding

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
This is available in GitHub for finding files, and actually even in the Chrome address bar.
With fuzzy finding, you can just type substrings of your desired string and the matcher will find items that contain those substrings.

For example, if I want the posts from 2015 that contain `galaxy`, I could type `2015galaxy`, and boom:

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
