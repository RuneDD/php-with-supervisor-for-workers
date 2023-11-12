# Docker Image with PHP and Supervisor for running Workers

PHP is not the best language for long running processes. Workers get into zombie state or they suddenly exit due to memory leaks. One trick to solve this is to execute your workers using a UNIX-like operating systems process monitor and control tool such as Supervisor (<http://supervisord.org/>).

Supervisor takes a list of commands, executes them and takes care if they are running or not.

The main idea of this approach is to have Supervisor manage your workers. Supervisor will start your worker command and keep it running indefinitely. If the worker command exits for any reason, Supervisor will automatically restart it. This ensures that your workers are always running.

## How to use this image

This image is configured with a volume at `/usr/src/app` to hold your application source code. It is also configured with another volume at `/etc/supervisor/conf.d` to hold the configuration files. Use that path if you would like to set up your worker commands.

This image includes `EXPOSE 9001` so you can access the web monitoring page running on such port.

As an example, you can define the command you want to execute, the minimum amount of time to consider that the process is working properly and if has to restart after finished.

    [program:my-general-worker]
    command=php /usr/src/app/bin/console worker:start my_queue 100
    startsecs=0
    autorestart=1

Specific usecase for queue processing at yii2 framework

    [program:my-queue-worker]
    command=php /usr/src/app/yii queue/listen
    startsecs=0
    autorestart=1

Specific usecase for queue processing at laravel framework

    [program:my-queue-worker]
    command=php /usr/src/app/artisan queue:work --tries=3
    startsecs=0
    autorestart=1

See `queue-processing.conf` for CRAFT CMS queue processing with supervisor. Specially usefull for long running tasks like image processing.

## License
Forked from <https://github.com/carlosbuenosvinos>
No license specified