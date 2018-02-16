# Docker - Laravel Utility Server

An all-in-one server for running a Laravel app as a docker instance. Make a lot of intentionally bad decisions and you should not use this in production unless you like pain. For example, this will poll git and update when it sees new pushes. That's a terrible idea right? Yes, terrible.

It's great for the projects you host on that raspberry pi in your closet, or that toolchain that you have running your own life-automation-service with. You know, the thing that checks your email and will turn on the coffee maker if you get start getting outage alerts after 3am? Maybe the tool you wrote to streamline the workload of a small 3 person business.

So this is a terrible, horrible way to do things that works great and is absolutely perfect for those other terrible ideas you love working on.

## Bad decisions

This container has these fancy things:

* Alpine 3.7
* NGINX
* PHP 7.2.1 with some useful modules (like pdo_mysql and gd)
* MySQL
* OpenSSH Client (not server)
* GIT

It assumes that you are running a Laravel app. It will do it's initial build by setting up the database (see the Environment variables below) then doing a git clone of the repo you provide (again, see the Environment variables section). If you let it, it will also do a git reset and git pull to self-update on a definable interval.

Oh, and about Laravel...

### Supervisor, queue workers and cron

The standard [Laravel cron thingy](https://laravel.com/docs/5.6/scheduling#introduction) is setup and running, so you can use that. There is also a queue worker setup (3 processes) to run against the high, default and low queue. It is running like this:

```
php artisan queue:work --daemon --delay=120 --tries=20 --no-interaction --queue=high,default,low
```

## Environment variables

* `MYSQL_ROOT_PASSWORD` - Sets the root password of MySQL  
* `MYSQL_DATABASE` - Creates this database for your Laravel project  
* `MYSQL_USER` - Creates this database user for your Laravel project  
* `MYSQL_PASSWORD` - Sets the database user to this password  
* `GIT_SSH_KEY` - The private **base64 encoded** SSH key used to connect to your git repo (if any). Must be base64 encoded or will fail.  
* `GIT_REPO` - The git repository to use for the clone and pull.  
* `GIT_AUTO_UPDATE` - Should we auto-update the local copy from git? [yes / no, default no]  
* `GIT_AUTO_UPDATE_INTERVAL` - Time between auto update checks, in seconds. [default 5]

## About the base64 encoded private key

I don't want to have to deal with all the cruft that can exist inside a private key, and I don't want to deal with newlines. By requiring that you base64 encode the private key before using it as an environment variable, it is letting me be super lazy.

However...

If your GIT repo needs an SSH key, you can provide it by using either the `GIT_SSH_KEY` environment variable **OR** by mount. If you use a mount, this example is correct:

```
    -v /dir/.ssh/my_key:/root/.ssh/id_rsa:ro
```

The important bit is to mount it into **/root/.ssh/id_rsa**. Also, probably don't overwrite the config file at **root/.ssh/id_rsa**. Or do. I wouldn't.

## About self-updating

The `GIT_AUTO_UPDATE` feature makes the assumption that you are okay with these shell commands being run according to the `GIT_AUTO_UPDATE_INTERVAL` definition:

```
git reset --hard HEAD
git pull
composer install
php artisan migrate
```
