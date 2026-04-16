# nvim_config

`nvim_config` 是一个可复制、可迁移的 portable 配置仓库。它把 Neovim 配置、tmux 配置和运行时目录收进同一个仓库，但外部命令仍由你的 conda 环境提供。

## Layout

- `bin/nvim-portable`: 统一启动入口，自动设置仓库内的 `XDG_*` 目录
- `bin/tmux-portable`: 统一启动 tmux，并导出仓库根路径给 portable tmux 配置
- `nvim/`: LazyVim-based Neovim 配置
- `tmux/tmux.conf`: tmux 配置
- `lazyvim_usage.md`: 使用笔记

## Install

首次拉取仓库时，如果需要 tmux portable 运行时，请记得连同 submodule 一起初始化：

```bash
git clone --recurse-submodules <your-repo-url>
```

如果仓库已经拉下来了，再补一次：

```bash
git submodule update --init --recursive
```

推荐 Neovim 版本：

- `Neovim 0.11.x`

主工具：

```bash
conda install -c conda-forge ripgrep tree-sitter-cli fd-find ty lua-language-server ruff vscode-langservers-extracted
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

推荐统一从仓库入口启动：

```bash
./bin/tmux-portable
```

如果你已经在 tmux 会话里，也可以重新加载：

```bash
PORTABLE_CONFIG_ROOT=/path/to/nvim_config \
TMUX_PLUGIN_MANAGER_PATH=/path/to/nvim_config/.local/share/tmux/plugins \
tmux source-file /path/to/nvim_config/tmux/tmux.conf
```

首次进入 tmux 后，请使用 TPM 安装声明的插件：

```bash
prefix + I
```

说明：

- `submodules/tpm/` 以 git submodule 方式固定 TPM 本体
- 其他 tmux 插件由 TPM 安装到仓库内 `.local/share/tmux/plugins/`
- `tmux/tmux.conf` 仅保留基础配置和 TPM 加载逻辑
- `tmux/` 只保留 tmux 配置文件；仓库级 submodule 统一放在 `submodules/`
- `tmux/themes/` 可用于存放你后续自己维护的主题配置
- 建议安装 Nerd Font 以正确显示图标

## Shell Integration

如果你想把 portable 环境变量和 alias 统一收拢到 shell 初始化里，可以在 `~/.bashrc` 或 `~/.zshrc` 中 source：

```bash
source /path/to/nvim_config/bin/portable-env.sh
eval "$(starship init bash)"
```

这个脚本会导出：

- `PORTABLE_CONFIG_ROOT`
- `STARSHIP_CONFIG`

并定义：

- `alias nvim=/path/to/nvim_config/bin/nvim-portable`
- `alias tmux=/path/to/nvim_config/bin/tmux-portable`

说明：

- `portable-env.sh` 只负责 shell 级共享变量和 alias
- `nvim-portable` / `tmux-portable` 仍负责各自命令的运行时隔离
- 不会全局导出 `XDG_CONFIG_HOME`、`XDG_DATA_HOME`、`XDG_STATE_HOME`、`XDG_CACHE_HOME`

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
