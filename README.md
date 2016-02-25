# devdocsbuf

devdocsbuf is a small plugin bridging the gap between [devdocs](https://github.com/Thibaut/devdocs) and vim. The plugin automates looking up devdocs, converting the result to markdown and opening the result in a new buffer in vim.

<img src="https://raw.githubusercontent.com/thomasthune/devdocsbuf/master/devdocsbuf.png" height="450">

## Requirements

The plugin relies on devdocs beeing set up locally and the html2text converting tool.

* [devdocs](https://github.com/Thibaut/devdocs) - 
  Install locally and download the wanted docs. Follow the excellent guide on the github page.

* [html2text](https://github.com/aaronsw/html2text) - 
  Install with pip `pip install [-g] html2text`, and make sure it is executable from your $PATH.

## How does it work

When called the plugin searches the index.json file for the given filetype, for a keyword matching the the word under the cursor. If a match i found, the html file is converted to markdown using html2text and opened in a new buffer.
If a exact match is not found, one that contains the word under the cursor is shown (see "Whats missing".

### Settings

`let g:devdocsbuf_devdocs_path = "/path/to/devdocs/public/docs/"`

## Useful mappings

Find docs for the current word, when pressing "K".

`nmap K :Devdocsbuf<cr>`

## Why?

I love the devdocs resources, but i hate leaving vim. So i thought, why not combine the two and make it even easier to view the docs, while writing some code.

## Whats missing

There are a number of things that i would like to add.

* Extend functionality when no exact match is found
* Manage installed devdocs from plugin
* Allow for filetype mapping

## License

MIT License, see LICENSE.
