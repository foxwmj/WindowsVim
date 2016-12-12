# Windows VIM

---

## 前置条件
- 安装好python
- 安装git，curl，方便VIM更新插件
	- 安装完之后，公司proxy运行 git config --global http.proxy https://web-proxyhk.oa.com:8080
- 设置Windows不要隐藏文件，方便排查问题


## 安装步骤
- 安装VIM： vim80\install.exe （管理员模式安装）
- 安装字体： fonts\ 所有字体安装
- **vim80可能不用** 注册VIM到右键菜单： 改变install\popup_menu.reg里的路径， 运行install\popup_menu.reg
- 解压缩vim.plug.runtime.zip到vim.plug.runtime

## 配置VIM 插件

 [详细配置Vim-Plug方法](https://github.com/junegunn/vim-plug)


- vim-plug插件安装地址配置： 修改_vimrc 
	- __注意：Windows下是用 双 \\\\分割__

```
call plug#begin("d:\\03_vim8_setup\\vim.plug.runtime")
```

- 在VIM里运行

```
:PlugInstall! 
```


## 配置YouCompleteMe插件

**非必须-Coding自动提醒**

VIM激活方法:

```
:call YCM()
```

[详细配置方法YouCompleteMe](https://github.com/Valloric/YouCompleteMe)