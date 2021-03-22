#!/usr/bin/env bash
set -e

if [[ "$1" = "api" || -z $1 ]];then

    # number of worker processes for handling requests. Default 1, Recommanded 2-4 x $(NUM_CORES)
    export G_WORKERS=${G_WORKERS:=5}
    # Types of worker to use. Default sync (each worker will handle on request at a time) see "Choosing a worker type" on https://docs.gunicorn.org/en/stable/design.html
    export G_WORKER_CLASS=${G_WORKER_CLASS:=sync}
    # number of worker threads for handling requests. Default 1, only for worker gthread (will force it if >1)
    export G_THREADS=${G_THREADS:=1}
    # max number of simultaneous client (only for eventlet and gevent), Default 1000
    export G_WORKER_CONNECTIONS=${G_WORKER_CONNECTIONS:=1000}
    # max number of requests a worker will process before restarting to avoid memory leaks, Default 1000
    export G_MAX_REQUESTS=${G_MAX_REQUESTS:=1000}
    # maximum jitter to add to max-request to randomize the exact number
    export G_MAX_REQUESTS_JITTER=${G_MAX_REQUESTS_JITTER:=20}
    # number of clients that can be waiting to be served. Exceeding this number results in the client getting an error when attempting to connect. Default 2048
    export G_BACKLOG=${G_BACKLOG:=5}
    # Workers silent for more than this many seconds are killed and restarted. Default 30, 0= infinite
    export G_TIMEOUT=${G_TIMEOUT:=300}
    # After receiving a restart signal, workers have this much time to finish serving requests.. Default 30
    export G_GRACEFUL_TIMEOUT=${G_GRACEFUL_TIMEOUT:=300}

    echo "starting api"
    exec gunicorn --bind 0.0.0.0:5000 --workers $G_WORKERS --worker-class $G_WORKER_CLASS \
    --threads $G_THREADS --backlog $G_BACKLOG --timeout $G_TIMEOUT --worker-connections $G_WORKER_CONNECTIONS \
    --graceful-timeout $G_GRACEFUL_TIMEOUT --access-logfile - \
    --access-logformat '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s %(l)ss "%(f)s" "%(a)s"' \
    --max-requests $G_MAX_REQUESTS --max-requests-jitter $G_MAX_REQUESTS_JITTER \
    main:app

elif [ "$1" = "main" ];then

    shift
    echo "run command : python main.py $@"
    exec python main.py $@

fi

echo "nothing to do"

