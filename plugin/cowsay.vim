" cowsay.vim -  just vim saying cowsay
" Maintainer:   mklabs


"  ____________
" < cowsay.vim >
"  ------------
"                        \                    ^    /^
"                         \                  / \  // \
"                          \   |\___/|      /   \//  .\
"                           \  /O  O  \__  /    //  | \ \           *----*
"                             /     /  \/_/    //   |  \  \          \   |
"                             @___@`    \/_   //    |   \   \         \/\ \
"                            0/0/|       \/_ //     |    \    \         \  \
"                        0/0/0/0/|        \///      |     \     \       |  |
"                     0/0/0/0/0/_|_ /   (  //       |      \     _\     |  /
"                  0/0/0/0/0/0/`/,_ _ _/  ) ; -.    |    _ _\.-~       /   /
"                              ,-}        _      *-.|.-~-.           .~    ~
"             \     \__/        `/\      /                 ~-. _ .-~      /
"              \____(oo)           *.   }            {                   /
"              (    (--)          .----~-.\        \-`                 .~
"              //__\\  \__ Ack!   ///.----..<        \             _ -~
"             //    \\               ///-._ _ _ _ _ _ _{^ - - - - ~
"

if exists("g:loaded_cowsay") || v:version < 700 || &cp
  " finish
endif

let g:loaded_cowsay = 1
let s:cowfile = 'default.cow'
let s:cowfiles = []


" < Utility >
"  ---------
"         \   ^__^
"          \  (oo)\_______
"             (__)\       )\/\
"                 ||----w |
"                 ||     ||

function! s:error(str)
  echohl ErrorMsg
  echo '... '. a:str . ' ...'
  echohl None
endfunction

"  _________________________________________
" / completion filter helper. borrowed to   \
" | vim-rails:                              |
" |                                         |
" | https://github.com/tpope/vim-rails/blob |
" \ /master/autoload/rails.vim#L2162-2173   /
"  -----------------------------------------
"    \
"     \
"         .--.
"        |o_o |
"        |:_/ |
"       //   \ \
"      (|     | )
"     /'\_   _/`\
"     \___)=(___/
"
function! s:completion_filter(results,A)
  let results = sort(type(a:results) == type("") ? split(a:results,"\n") : copy(a:results))
  call filter(results,'v:val !~# "\\~$"')
  let filtered = filter(copy(results),'s:startswith(v:val,a:A)')
  if !empty(filtered) | return filtered | endif
  let regex = s:gsub(a:A,'[^/]','[&].*')
  let filtered = filter(copy(results),'v:val =~# "^".regex')
  if !empty(filtered) | return filtered | endif
  let regex = s:gsub(a:A,'.','[&].*')
  let filtered = filter(copy(results),'v:val =~# regex')
  return filtered
endfunction

function! s:gsub(str,pat,rep)
  return substitute(a:str,'\v\C'.a:pat,a:rep,'g')
endfunction

function! s:startswith(string,prefix)
  return strpart(a:string, 0, strlen(a:prefix)) ==# a:prefix
endfunction

"  _________________________________________
" /  ## Commands                            \
" |                                         |
" | Commands below accepts arguments or     |
" | visual range.                           |
" |                                         |
" | ### :Cowsay                             |
"  -----------------------------------------
"         \   ^__^
"          \  (oo)\_______
"             (__)\       )\/\
"                 ||----w |
"                 ||     ||

function! s:Cow(args, ...)
  if !executable('cowsay')
    return s:error('cowsay is not installed')
  endif

  if a:args != ""
    let lines = a:args
  else
    let lines = join(getline(a:1, a:2), "\n")
  endif

  let cow = system('cowsay -f ' . s:cowfile, lines)
  return cow
endfunction

function! s:CowSay(args, ...)
  let cow = s:Cow(a:args, a:1, a:2)
  echo cow
endfunction

function! s:CowInsert(args, ...)
  let cow = s:Cow(a:args, a:1, a:2)
  let lines = split(cow, "\n")
  exe ':' a:1 ',' a:2 'd'
  call append(a:1 - 1, lines)
  return lines
endfunction

function! s:CowComment(args, ...)
  let lines = s:CowInsert(a:args, a:1, a:2)
  if exists("g:loaded_tcomment")
    let end = a:1 + len(lines)
    call tcomment#Comment(a:1, end - 1)
  endif
endfunction

"  ________________________________
" < Let's allow some other cows... >
"  --------------------------------
"           \
"            \
"             \          __---__
"                     _-       /--______
"                __--( /     \ )XXXXXXXXXXX\v.
"              .-XXX(   O   O  )XXXXXXXXXXXXXXX-
"             /XXX(       U     )        XXXXXXX\
"           /XXXXX(              )--_  XXXXXXXXXXX\
"          /XXXXX/ (      O     )   XXXXXX   \XXXXX\
"          XXXXX/   /            XXXXXX   \__ \XXXXX
"          XXXXXX__/          XXXXXX         \__---->
"  ---___  XXX__/          XXXXXX      \__         /
"    \-  --__/   ___/\  XXXXXX            /  ___--/=
"     \-\    ___/    XXXXXX              '--- XXXXXX
"        \-\/XXX\ XXXXXX                      /XXXXX
"          \XXXXXXXXX   \                    /XXXXX/
"           \XXXXXX      >                 _/XXXXX/
"             \XXXXX--__/              __-- XXXX/
"              -XXXXXXXX---------------  XXXXXX-
"                 \XXXXXXXXXXXXXXXXXXXXXXXXXX/
"                   ""VXXXXXXXXXXXXXXXXXXV""

function! s:Cowfile(file)
  if a:file == ""
    echo 'No Cowfile provided, current one is ' s:cowfile
    return
  endif

  if index(s:cowfiles, a:file) == -1
    return s:error('... not a valid cowfile '. a:file . '...')
  endif

  let s:cowfile = a:file
endfunction

function! s:init_cowfiles()
  if len(s:cowfiles) == 0
    let s:cowfiles = split(system('ls /usr/local/share/cows'), "\n")
  endif

  " if there's a user define cowfile, use this
  if exists('g:cowsay_cowfile')
    call s:Cowfile(g:cowsay_cowfile)
  endif

  return s:cowfiles
endfunction

function! s:Complete_cowfiles(A,L,P)
  return s:completion_filter(s:cowfiles, a:A)
endfunction

call s:init_cowfiles()


command! -nargs=* -range Cowsay                                     call s:CowSay(<q-args>, <line1>, <line2>)
command! -nargs=* -range Cow                                        call s:CowInsert(<q-args>, <line1>, <line2>)
command! -nargs=* -range CowComment                                 call s:CowComment(<q-args>, <line1>, <line2>)

command! -nargs=? -complete=customlist,s:Complete_cowfiles Cowfile  call s:Cowfile(<q-args>)



