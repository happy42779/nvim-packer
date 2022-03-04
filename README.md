# My Nvim Config
## Installation
- Make a folder in your home directory and name it .config if it doesn't exist yet: `mkdir ~/.config`
- Clone this git into `~/.config` folder: 
	`git clone https://github.com/happy42779/nvim.git`

## Configuration
There's no need to configure every plugin again, but installing some of the dependents needed by several plugins is necessary.
```
# LSP 
# this list could get longer, remember to add to this if there's more
1. pyright	'npm i -g pyright'
2. clangd	'npm i -g clangd'
3. tsserver ''

# Markdown Preview

```
## Manuals
Directory of `nvim` should look like this.

-nvim							'main folder'
├── init.lua					'start point'
├── lua							'folder of configs'
│   ├── mappings.lua			'all the key mappings'
│   ├── options.lua				'normal neovim settings'
│   ├── pack.lua				'packer config'
│   └── plugins					'specific configs of plugins needed extra config'
│       ├── autopairs.lua		'filename says a lot'
│       ├── bufferline.lua		'... tab bar'
│       ├── cmp.lua				'... lsp autocompletion'
│       ├── lspconfig.lua		'...'
│       └── lualine.lua			'... status line'
├── plugin
│   └── packer_compiled.lua		'this will be generated after running PackerCompile'
└── README.md-	nvim

## References
- [Collections of plugins](https://github.com/rockerBOO/awesome-neovim)
- [Neovim Doc](https://neovim.io/doc/user/index.html): `keymap`, `options`, `lua`
- [LSPCONFIG](https://github.com/neovim/nvim-lspconfig)
- [LSPCONFIG AutoCompletion](https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion)
- [LSPCONFIG Servers](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
