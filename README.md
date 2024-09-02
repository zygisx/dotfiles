
*bash_rc*

`bash_rc` split into multiple files not to mix personal utilities with others
 

For mac:

inside `~/.bash_profile`:

```
[ -r ~/.bashrc ] && source ~/.bashrc
```

inside `~/.bashrc`

```
source ~/.bashrc_productivity
... other bashrc ...
```