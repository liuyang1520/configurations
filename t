[1;32minstructions/vim.md[0m[K:[1;33m224[0m[K:2:`[30;43m<leader[0m[K> + u`
[1;32minstructions/vim.md[0m[K:[1;33m236[0m[K:5: * `[30;43m<leader[0m[K>gs` :Gstatus<CR>
[1;32minstructions/vim.md[0m[K:[1;33m237[0m[K:5: * `[30;43m<leader[0m[K>gd` :Gdiff<CR>
[1;32minstructions/vim.md[0m[K:[1;33m238[0m[K:5: * `[30;43m<leader[0m[K>gc` :Gcommit<CR>
[1;32minstructions/vim.md[0m[K:[1;33m239[0m[K:5: * `[30;43m<leader[0m[K>gb` :Gblame<CR>
[1;32minstructions/vim.md[0m[K:[1;33m240[0m[K:5: * `[30;43m<leader[0m[K>gl` :Glog<CR>
[1;32minstructions/vim.md[0m[K:[1;33m241[0m[K:5: * `[30;43m<leader[0m[K>gp` :Git push<CR>
[1;32minstructions/vim.md[0m[K:[1;33m242[0m[K:5: * `[30;43m<leader[0m[K>gw` :Gwrite<CR>
[1;32mdotfiles/init.lua[0m[K:[1;33m144[0m[K:28:      vim.keymap.set("n", "[30;43m<leader[0m[K>e", "<cmd>NvimTreeFindFileToggle<CR>",
[1;32mdotfiles/init.lua[0m[K:[1;33m151[0m[K:10:      { "[30;43m<leader[0m[K>tl", "<cmd>AerialToggle!<CR>" },
[1;32mdotfiles/init.lua[0m[K:[1;33m192[0m[K:24:      keymap.set("n", "[30;43m<leader[0m[K>qsr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
[1;32mdotfiles/init.lua[0m[K:[1;33m193[0m[K:24:      keymap.set("n", "[30;43m<leader[0m[K>qss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
[1;32mdotfiles/init.lua[0m[K:[1;33m271[0m[K:42:      vim.keymap.set({ 'n', 'v', 'x' }, "[30;43m<leader[0m[K>Pf", function()
[1;32mdotfiles/init.lua[0m[K:[1;33m278[0m[K:28:      vim.keymap.set('n', '[30;43m<leader[0m[K>tpf', ':ToggleAutoFormat<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m292[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>f', ':Files<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m293[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>F', ':Files!<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m294[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>h', ':History<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m295[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>H', ':History!<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m296[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>j', ':Jumps<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m297[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>b', ':Buffers<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m298[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>B', ':Buffers!<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m299[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>w', ':Windows<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m300[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>c', ':BCommits!<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m301[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>r', ':History:<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m302[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>s', ':S <C-R><C-W><CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m303[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>S', ':S! <C-R><C-W><CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m304[0m[K:31:vim.api.nvim_set_keymap('v', '[30;43m<Leader[0m[K>s', 'y:S <C-r>=fnameescape(@")<CR><CR>', { noremap = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m305[0m[K:31:vim.api.nvim_set_keymap('v', '[30;43m<Leader[0m[K>S', 'y:S! <C-r>=fnameescape(@")<CR><CR>', { noremap = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m329[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>ptt', ':TagbarToggle<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m334[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>gs', ':Git<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m335[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>gd', ':Gdiff<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m336[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>gc', ':Gcommit<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m337[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>gb', ':Git blame<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m338[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>gl', ':Gclog<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m339[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>gh', ':0Gclog<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m343[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m364[0m[K:22:    bufmap({ 'n' }, '[30;43m<leader[0m[K>pf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
[1;32mdotfiles/init.lua[0m[K:[1;33m365[0m[K:27:    bufmap({ 'x', 'v' }, '[30;43m<leader[0m[K>pf', '<cmd>lua vim.lsp.buf.format({async = true})<cr><Esc>')
[1;32mdotfiles/init.lua[0m[K:[1;33m599[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>mtl', ':tabm -1<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m600[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>mtr', ':tabm +1<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m606[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>/', ':nohlsearch<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m609[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>mc', [[/\v^[<\|=>]{7}( .*\|$)<CR>]], { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m628[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>il', ':set cursorcolumn!<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m631[0m[K:31:vim.api.nvim_set_keymap('n', '[30;43m<Leader[0m[K>=', '<C-w>=', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m644[0m[K:31:vim.api.nvim_set_keymap('v', '[30;43m<leader[0m[K>d', 'y\'>p', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m651[0m[K:33:  vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>cfr', ':let @*=expand("%")<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m654[0m[K:33:  vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>cfa', ':let @*=expand("%:p")<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m657[0m[K:33:  vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>cff', ':let @*=expand("%:t")<CR>', { noremap = true, silent = true })
[1;32mdotfiles/init.lua[0m[K:[1;33m660[0m[K:33:  vim.api.nvim_set_keymap('n', '[30;43m<leader[0m[K>cfd', ':let @*=expand("%:p:h")<CR>', { noremap = true, silent = true })
[1;32mdotfiles/.vimrc[0m[K:[1;33m95[0m[K:18:        nnoremap [30;43m<leader[0m[K>cs :<C-u>CocCommand workspace.showOutput<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m109[0m[K:14:        vmap [30;43m<leader[0m[K>pf <Plug>(coc-format-selected)
[1;32mdotfiles/.vimrc[0m[K:[1;33m110[0m[K:14:        nmap [30;43m<leader[0m[K>pf <Plug>(coc-format-selected)
[1;32mdotfiles/.vimrc[0m[K:[1;33m140[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>f :Files<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m141[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>F :Files!<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m142[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>h :History<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m143[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>H :History!<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m144[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>b :Buffers<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m145[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>B :Buffers!<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m146[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>w :Windows<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m147[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>c :BCommits!<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m148[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>r :History:<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m175[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>s :S <C-R><C-W><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m176[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>S :S! <C-R><C-W><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m177[0m[K:18:        vnoremap [30;43m<Leader[0m[K>s y:S <C-r>=fnameescape(@")<CR><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m178[0m[K:18:        vnoremap [30;43m<Leader[0m[K>S y:S! <C-r>=fnameescape(@")<CR><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m181[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>t :Tags <C-R><C-W><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m182[0m[K:27:        nnoremap <silent> [30;43m<Leader[0m[K>T :Tags! <C-R><C-W><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m183[0m[K:18:        vnoremap [30;43m<Leader[0m[K>t y:Tags <C-r>=fnameescape(@")<CR><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m184[0m[K:18:        vnoremap [30;43m<Leader[0m[K>T y:Tags! <C-r>=fnameescape(@")<CR><CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m201[0m[K:17:            map [30;43m<leader[0m[K>e :NERDTreeFind<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m202[0m[K:18:            nmap [30;43m<leader[0m[K>nt :NERDTreeFind<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m223[0m[K:14:        nmap [30;43m<leader[0m[K>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m229[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>ptt :TagbarToggle<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m235[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>gs :Git<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m236[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>gd :Gdiff<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m237[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>gc :Gcommit<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m238[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>gb :Git blame<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m239[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>gl :Gclog<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m240[0m[K:31:            nnoremap <silent> [30;43m<leader[0m[K>gh :0Gclog<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m246[0m[K:22:            nnoremap [30;43m<Leader[0m[K>u :UndotreeToggle<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m255[0m[K:18:            nmap [30;43m<leader[0m[K>il :IndentLinesToggle<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m444[0m[K:9:    map [30;43m<Leader[0m[K>mtl :tabm -1<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m445[0m[K:9:    map [30;43m<Leader[0m[K>mtr :tabm +1<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m465[0m[K:19:    nmap <silent> [30;43m<leader[0m[K>/ :nohlsearch<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m468[0m[K:9:    map [30;43m<leader[0m[K>mc /\v^[<\|=>]{7}( .*\|$)<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m487[0m[K:10:    nmap [30;43m<Leader[0m[K>cc :set cursorcolumn!<cr>
[1;32mdotfiles/.vimrc[0m[K:[1;33m490[0m[K:9:    map [30;43m<Leader[0m[K>= <C-w>=
[1;32mdotfiles/.vimrc[0m[K:[1;33m497[0m[K:23:    nnoremap <silent> [30;43m<leader[0m[K>q gwip
[1;32mdotfiles/.vimrc[0m[K:[1;33m508[0m[K:16:      nnoremap [30;43m<leader[0m[K>cfr :let @*=expand("%")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m510[0m[K:16:      nnoremap [30;43m<leader[0m[K>cfa :let @*=expand("%:p")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m512[0m[K:16:      nnoremap [30;43m<leader[0m[K>cff :let @*=expand("%:t")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m514[0m[K:16:      nnoremap [30;43m<leader[0m[K>cfd :let @*=expand("%:p:h")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m519[0m[K:16:      nnoremap [30;43m<leader[0m[K>cfr :let @+=expand("%")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m521[0m[K:16:      nnoremap [30;43m<leader[0m[K>cfa :let @+=expand("%:p")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m523[0m[K:16:      nnoremap [30;43m<leader[0m[K>cff :let @+=expand("%:t")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m525[0m[K:16:      nnoremap [30;43m<leader[0m[K>cfd :let @+=expand("%:p:h")<CR>
[1;32mdotfiles/.vimrc[0m[K:[1;33m529[0m[K:10:    vmap [30;43m<leader[0m[K>d y'>p
