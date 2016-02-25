if exists("g:loaded_devdocsbuf") || &cp | finish | endif
let g:loaded_devdocsbuf = 1

function! s:OpenDoc(word, ft) abort
    let  word = shellescape(a:word)
    let  ft = shellescape(a:ft)
    echo "Fetching docs for " . word

    " Use python to read devdocs index.json file
    python << EOF
import vim
import json

devdocs_path = vim.eval("g:devdocsbuf_devdocs_path")

filetype = vim.eval("a:ft")
search_string = vim.eval("a:word")

with open(devdocs_path + filetype + "/index.json") as json_file:
    json_data = json.load(json_file)

exact_match = None
other_match = None
# Loop over entries in index.json
for item in json_data['entries']:
    # Check if the item if for function we are looking for.
    if item['name'] == search_string:
        exact_match = item['path']
        #break!

    if search_string in item['name']:
        other_match = item['path']

if exact_match is None:
    if other_match is None:
        vim.command("let devdocs_file = 0");
    else:
        exact_match = other_match

filename = exact_match

if filename is not None:
    file_path = devdocs_path + filetype + "/" + filename + ".html";

    vim.command("let devdocs_file = '%s'"% file_path);
EOF

    if devdocs_file == "0"
        echo "no match"
        return
    endif

    " Get the devdocs as markdown
    let devdocs = system("html2text " . devdocs_file . " 2>&1")

    " if v:shell_error == 1
        " echom devdocs
        " return
    " endif

    " Open a new split and set it up.
    vsplit __DevDocs__
    normal! ggdG
    setlocal filetype=markdown
    setlocal buftype=nofile

    " insert devdocs
    call append(0, split(devdocs, '\v\n'))

    " make buffer closeable on q
    nnoremap <buffer> <silent> q :<C-U>bdelete<CR>

    " go to top of buffer
    normal! gg
    call feedkeys(" ")
endfunction

command! -bang -complete=buffer -nargs=? Devdocsbuf
	\ :call s:OpenDoc(expand('<cword>'), &l:ft)
