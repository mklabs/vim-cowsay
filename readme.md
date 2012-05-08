
cowsay.vim
==============

**just vim saying cowsay**

```
 ____________________
< Vimmmmmmeuuuuuuuuh >
 --------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
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


Install
-------

Just drop this vim script in one of your runtime path, `~/.vim/plugin/`
maybe. Or if you use pathogen you might want to bundle it as a pathogen
module,

```sh
cd ~/.vim/bundle
git clone <gistcloneturl> cowsay.vim
cd cowsay.vim
mkdir plugin && mv cowsay.vim plugin/
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


