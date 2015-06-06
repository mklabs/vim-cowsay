
cowsay.vim
==============

**just vim saying cowsay**

```
 ____________
< Cowsay.vim >
 ------------
        \    ,-^-.
         \   !oYo!
          \ /./=\.\______
               ##        )\/\
                ||-----w||
                ||      ||

               Cowth Vader
```

cowsay.vim is a simple wrapper to [cowsay](http://www.nog.net/~tony/warez/cowsay.shtml)

Right now, cowsay.vim is pretty dumb. But it does it very well.

Commands
--------


## Commands

Commands below accepts arguments or visual range.

### :Cowsay

Output the cow, a simple echo.

```
:Cowsay Wait what!?
 _____________
< Wait what!? >
 -------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

### :Cow

Same as ':Cowsay', expect that it replaces the selected lines (if used in
visual mode) or append what the cow said below the cursor.

Assume you're writing this fancy readme, and that you have the two
paragraph here starting at line 48 and ending at line 52. Running
`:48,52Cow` should replace the specified lines by...:

```
:48,52Cow
 _________________________________________
/ Same as ':Cowsay', expect that it       \
| replaces the selected lines (if used in |
| visual mode) or append what the cow     |
| said below the cursor.                  |
|                                         |
| Assume you're writing this fancy        |
| readme, and that you have the two       |
| paragraph here starting at line 48 and  |
\ ending at line 52.                      /
 -----------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

Visual range works too!


### :CowComment

Same as ':Cow', expect that it also triggers :TComment if is
installed.

### :Cowfile

Switch default `'cowfile'` to given argument. If no argument provided, then it
displays the active one. Basic completion should be supported with all
available cowfile (stored in `/usr/local/share/cows`)

Relatedly, you might want to run the `lscowfile.sh` script to see them all
(there are some funny cowfile in there...)

Install
-------

Via pathogen

```sh
git clone git://github.com/mklabs/vim-cowsay.git ~/.vim/bundle/vim-cowsay
```
Make sure to have cowsay installed and available in your path.

If not, simply copy and paste:

```sh
curl -o cowsay-3.03.tar.gz http://www.nog.net/~tony/warez/cowsay-3.03.tar.gz
tar xvzf cowsay-3.03.tar.gz
rm cowsay-3.03.tar.gz
cd cowsay-3.03/
./install.sh
rm -rf cowsay-3.03/
```

License & Acknowledgement
-------------------------

License: Same as Vim. See `:help license`.


