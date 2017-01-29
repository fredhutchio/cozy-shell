# Puritanical shell scripting

This post and talk is inspired by Ryan Tomayko's *Shell Hater's Handbook* [talk](http://confreaks.tv/videos/gogaruco2010-the-shell-hater-s-handbook) and [manual](http://shellhaters.org/) to the shell.

The "puritanical" philosophy of shell scripting is that shell is *not* a general-purpose programming language.
Shell is a programming language that is designed for assembling and running other commands.
That's wonderful in a lot of cases, but it's not a great approach for others.


## When not to use shell

Shell, along with the associated utilities such as sed and awk, is a very powerful programming language.
Variants such as bash make this even more powerful, adding arrays and algebraic evaluation.

Puritans know that if you need something more than composition of commands, it's time to reach for a more suitable programming language such as Python.
Python will be able to handle your needs as they expand and become more complex.
Nevertheless, shell scripts are very handy and a great tool.


## Your first shell script

Shell scripting is to first approximation just writing what you would write in the interactive shell in a file and then running it.
`echo` is a command that simply echoes its arguments back to you.

```
#! /bin/sh

set -eu

echo "Twinkle twinkle little *"
```

Save this in `test.sh` and make it executable using `chmod +x test.sh`.
Now we can execute it:

```
$ ./test.sh
Twinkle twinkle little *
$
```

As you can see, to execute a command in a shell script, you just put it on a line and it gets called.

Now, what is this `set -eu` bit?
Although the script will run without it, I strongly suggest that every script you write contain this line.
Adding it will make your shell script fail and print an error message when either a command fails or a variable substitution did not work.
That's what you would expect, right?


## Using predefined variables

One of the key aspects of shell is variable substitution: substituting in the value of a variable.
To demonstrate, we'll use some pre-defined variables.
We can do this directly in the interactive shell.

```
$ echo "My name is $USER and my editor is $EDITOR."
My name is matsen and my editor is vim
$
```

There are lots of pre-defined variables, and you can see them using the `env` command.


## [Quoting](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02)

If you don't know about quoting, there is a key point here: the quotes make the argument of `echo` a single item.
If instead we tried

```
$ echo Twinkle twinkle little *
```

this echoes `Twinkle twinkle little` with all of the other files I have in my directory, because `*` is a pattern that [matches all characters](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13).

You might have noticed that the double quotes with variables above didn't actually perfectly preserve the string we put into echo.
Rather, the value of the variables were substituted in.
Sometimes this is the effect we want, but sometimes we literally want a string with a dollar sign.

For this there are single quotes:

```
$ echo 'My name is $USER and my editor is $EDITOR'
My name is $USER and my editor is $EDITOR
$
```

Note that we could have achieved the same effect using backslashes, which remove the special meaning of characters.

```
$ echo "My name is \$USER and my editor is \$EDITOR"
My name is $USER and my editor is $EDITOR
$
```


## Command substitution

We'd like to be able to use the result of one command as the input for another.
We can do this using backticks `\``, but I prefer the more explicit `$( )` notation, which also nests properly.

For example, say we have a nested directory structure like so:
```
$ tree
.
├── buckle
│   └── shoe
└── one
    └── two
```

When we `ls`, we get the first level:

```
$ ls
buckle  one
```

When we call `ls $(ls)`, we are calling `ls` on the result of calling `ls`, which as we saw above is `ls buckle shoe`:

```
$ ls $(ls)
buckle:
shoe

one:
two
```


## Defining variables

You know now that variables are there to store strings for later substitution.
You define them like so:

```
color="chicken"
```

It's common to use all caps for shell variables:

```
COLOR="chicken"
```

which means that you won't confuse them with commands, though you don't have to follow that convention.

Now we can use the variable:

```
$ COLOR="chicken"; echo "Roses are red, violets are $COLOR"
Roses are red, violets are chicken
```

It's common to use set variables to the value of commands.
For example:

```
$ DATE=$(date); sleep 3; echo "3 seconds ago it was $DATE"
```

So far we've been using variables in situations where the termination of the variable is clear, such as at the end of the string.
This need not always be the case.
For example, we might want to substitute in the value of `COLOR` as so:

```
$ COLOR="blue"; echo "Let's paint the wall $COLORish"
```

Instead of getting the output "Let's paint the wall blueish", the shell interprets `COLORish` as its own variable, which isn't defined.

The right syntax is `${VARIABLE}otherstuff`:

```
$ COLOR="blue"; echo "Let's paint the wall ${COLOR}ish"
Let's paint the wall blueish
$
```


## Return codes

Return codes are how programs communicate if they succeeded or how they failed.
They also form the basis of the conditional execution system in shell.
In principle they go from 0 to 255, but you only need to know that 0 is success and anything else is a failure.
This might sound backwards (and is indeed opposite of languages such as Python), but in shell there are lots more ways to fail than there are to succeed.
We have heard of these concepts above in the discussion of `set -eu`.

These concepts are used in AND lists and OR lists.

* `cmd && other_cmd`: `other_cmd` will only be run if `cmd` succeeds
* `cmd || other_cmd`: `other_cmd` will only be run if `cmd` fails


Here it is in action:

```
$ ls gefilte_fish && echo "we have fish"
ls: cannot access 'gefilte_fish': No such file or directory
$  ls gefilte_fish || echo "we have no fish"
ls: cannot access 'gefilte_fish': No such file or directory
we have no fish
```

We only got the echo message in the second case because the `ls` command failed each time (because I didn't have a file named `gefilte_fish`).

We can avoid the error message by using [`test`](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#top).

```
$ test -e gefilte_fish && echo "we have fish"
$ test -e gefilte_fish || echo "we have no fish"
we have no fish
```


