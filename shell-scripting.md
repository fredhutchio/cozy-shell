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


## Containing variable names


