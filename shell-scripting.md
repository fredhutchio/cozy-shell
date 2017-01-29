# Puritanical shell scripting

This post and talk is inspired by Ryan Tomayko's *Shell Hater's Handbook* [talk](http://confreaks.tv/videos/gogaruco2010-the-shell-hater-s-handbook) and [manual](http://shellhaters.org/) to the shell.

The "puritanical" philosophy of shell scripting is that shell is *not* a general-purpose programming language.
Shell is a programming language that is designed for assembling and running other commands.
The fundamental abstraction of shell is a command.


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

echo "Twinkle twinkle little *"
```

Save this in `test.sh` and make it executable using `chmod +x test.sh`.
Now we can execute it:

```
$ ./test.sh
Twinkle twinkle little *
$
```


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


## Containing variable names



