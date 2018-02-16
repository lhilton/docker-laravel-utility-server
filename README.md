#Hipster Docker for Small Laravel Projects

##Environment variables

`MYSQL_ROOT_PASSWORD`: Sets the root password of MySQL
`MYSQL_DATABASE`: Creates this database for your Laravel project
`MYSQL_USER`: Creates this database user for your Laravel project
`MYSQL_PASSWORD`: Sets the database user to this password

`GIT_SSH_KEY`: The private **base64 encoded** SSH key used to connect to your git repo (if any). Must be base64 encoded or will fail.
`GIT_REPO`: The git repository to use for the clone and pull.
`GIT_AUTO_UPDATE`: Should we auto-update the local copy from git? [yes / no, default no]
`GIT_AUTO_UPDATE_INTERVAL`: Time between auto update checks, in seconds. [default 5]

If your GIT repo needs an SSH key, you can provide it by using either the `GIT_SSH_KEY` environment variable or a mount. If you use the key you **must base64 encode** the key first, otherwise it will fail. If you use a mount, this example is correct: `-v /dir/.ssh/my_key:/root/.ssh/id_rsa:ro`
