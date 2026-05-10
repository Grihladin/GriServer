# Bun as Node

Some tools look for `node` but we only have Bun installed.
I applied Fix by symlinking bun to node (node is not installed on purpose DONT INSTALL NODE):

```bash
mkdir -p ~/.local/bin
ln -s $(which bun) ~/.local/bin/node
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Now when any tool calls `node`, it runs Bun instead.