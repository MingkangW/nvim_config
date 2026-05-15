# nvim_config

`nvim_config` 是一个可复制、可迁移的配置仓库。它把 Neovim 配置、tmux 配置和 starship 配置收进同一个仓库，但外部命令仍由你的 conda 环境提供。

## Layout

- `bin/install.sh`: 安装脚本，把仓库配置软链接到标准配置位置
- `nvim/`: LazyVim-based Neovim 配置
- `tmux/tmux.conf`: tmux 配置
- `starship/starship.toml`: starship 配置
- `lazyvim_usage.md`: 使用笔记

## Install

首次拉取仓库时，请记得连同 submodule 一起初始化：

```bash
git clone --recurse-submodules <your-repo-url>
```

如果仓库已经拉下来了，再补一次：

```bash
git submodule update --init --recursive
```

安装配置：

```bash
./bin/install.sh
```

这个脚本会自动创建下面这些软链接，如果目标路径已存在，会先备份成 `*.bak.<timestamp>`：

- `~/.config/nvim -> <repo>/nvim`
- `~/.tmux.conf -> <repo>/tmux/tmux.conf`
- `~/.config/starship.toml -> <repo>/starship/starship.toml`
- `~/.tmux/plugins/tpm -> <repo>/submodules/tpm`

如果你之前在 `~/.bashrc` 或 `~/.zshrc` 里写过旧的 alias、wrapper 或 `source` 逻辑，现在可以一并删除，安装后直接使用系统的 `nvim` 和 `tmux` 即可。

推荐 Neovim 版本：

- `Neovim 0.11.x`

主工具：

```bash
conda install -c conda-forge ripgrep tree-sitter-cli fd-find ty lua-language-server ruff vscode-langservers-extracted markdownlint-cli2
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

安装完成后直接使用系统默认入口：

```bash
nvim
tmux
```

首次启动需要访问 GitHub 拉取 `lazy.nvim` 和插件。如果当前环境无法访问 GitHub，启动会在 bootstrap 阶段失败。

## Tmux

如果你已经在 tmux 会话里，也可以重新加载：

```bash
tmux source-file ~/.tmux.conf
```

首次进入 tmux 后，请使用 TPM 安装声明的插件：

```bash
prefix + I
```

说明：

- `submodules/tpm/` 以 git submodule 方式固定 TPM 本体
- `~/.tmux/plugins/tpm` 是指向仓库 `submodules/tpm/` 的软链接
- 其他 tmux 插件默认由 TPM 安装到 `~/.tmux/plugins/`
- `tmux/tmux.conf` 仅保留基础配置和 TPM 加载逻辑
- `tmux/` 只保留 tmux 配置文件；仓库级 submodule 统一放在 `submodules/`
- `tmux/themes/` 可用于存放你后续自己维护的主题配置
- 建议安装 Nerd Font 以正确显示图标

## Python

- 默认 LSP: `ty`
- 可通过环境变量切换：

```bash
PORTABLE_CONFIG_PYTHON_LSP=pyright nvim
```

## Migration Notes

- 现在通过 `./bin/install.sh` 创建标准路径软链接
- 安装完成后直接使用 `nvim` / `tmux`
- 外部命令由 conda 环境提供，仓库本身不管理工具二进制
