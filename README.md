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
This needs `tslib` to be installed, I prefer using `npm i -g tslib` to keep `nvim` folder clean.

```

## Mappings
The	*Alt* key is not working properly, so there're some key mappings not working. You need to change the setting: 

iTerm2: `Preferences` -> `Profiles` -> `Key Mappings` -> `Left Option key` -> check `Esc+`

Terminal: `Preferences` -> `Profiles` -> `Keyboard` -> check `Use Option as Meta key`

	> iTerm2 is recommended, as the some colorscheme(tokyonight) is not working properly with 
	the default Terminal.app.

For other key mappings, please refer to `mappings.lua`. 

## Manuals
Directory of `nvim` should look like this.
```md
-nvim
├── init.lua			'start point'
├── lua				'folder of configs'	
│   ├── mappings.lua		'key mappings'	
│   ├── options.lua		'common neovim options'	
│   ├── pack.lua		'packer config'
│   └── plugins			'configs of plugins need extra configs'
│       ├── autopairs.lua	'filename explains'
│       ├── bufferline.lua	'tab bar'
│       ├── cmp.lua		'...'
│       ├── lspconfig.lua	'...'
│       └── lualine.lua		'status line'	
├── plugin			'this folder will be generated after running :PackerCompile'
│   └── packer_compiled.lua	
└── README.md-	nvim

```

## References
- [Collections of plugins](https://github.com/rockerBOO/awesome-neovim)
- [Neovim Doc](https://neovim.io/doc/user/index.html): `keymap`, `options`, `lua`
- [LSPCONFIG](https://github.com/neovim/nvim-lspconfig)
- [LSPCONFIG AutoCompletion](https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion)
- [LSPCONFIG Servers](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
