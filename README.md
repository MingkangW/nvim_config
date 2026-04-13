# nvim_config

`nvim_config` 是一个可复制、可迁移的 portable 配置仓库。它把 Neovim 配置、tmux 配置和运行时目录收进同一个仓库，但外部命令仍由你的 conda 环境提供。

## Layout

- `bin/nvim-portable`: 统一启动入口，自动设置仓库内的 `XDG_*` 目录
- `nvim/`: LazyVim-based Neovim 配置
- `tmux/tmux.conf`: tmux 配置
- `lazyvim_usage.md`: 使用笔记

## Install

推荐 Neovim 版本：

- `Neovim 0.11.x`

主工具：

```bash
conda install -c ripgrep tree-sitter-cli fd-find ty lua-language-server ruff vscode-langservers-extracted
```

调试支持：

```bash
pip install debugpy
```

可选工具：

```bash
conda install -c conda-forge lua=5.1.5 luarocks stylua
```

说明：

- 默认 Python LSP 是 `ty`
- 如需切换到 `pyright`，单独安装 `pyright-langserver`
- `lua-language-server` 用于 Lua 跳转和诊断
- `debugpy` 用于 Python 调试
- `lua=5.1.5` 和 `luarocks` 不是启动必需，只在你需要独立 Lua 运行时或 rocks 时使用

## Start

```bash
./bin/nvim-portable
```

首次启动会把 Lazy 插件和状态目录写到仓库内部：

- `.local/share`
- `.local/state`
- `.cache`

首次启动需要访问 GitHub 拉取 `lazy.nvim` 和插件。如果当前环境无法访问 GitHub，启动会在 bootstrap 阶段失败。

如果你想确认是否真的隔离到了仓库内部，可以运行：

```bash
./bin/nvim-portable --headless '+lua print(vim.fn.stdpath("config"))' '+lua print(vim.fn.stdpath("data"))' '+qa'
```

## Tmux

加载 tmux 配置：

```bash
tmux source-file /path/to/nvim_config/tmux/tmux.conf
```

## Python

- 默认 LSP: `ty`
- 可通过环境变量切换：

```bash
PORTABLE_CONFIG_PYTHON_LSP=pyright ./bin/nvim-portable
```

## Migration Notes

- 不再把仓库根目录当作 `~/.config/nvim` 使用
- 推荐统一从 `./bin/nvim-portable` 启动
- 外部命令由 conda 环境提供，仓库本身不管理工具二进制
