# MongoDB Shell Docker Container

This is a Docker container running MongoDB Shell as a one-line command.

It is meant to be run with the `--rm` parameter so the container gets discarded right away.

## Usage

```bash
docker run \
    -it \
    --rm \
    -v /path/to/data:/data \
    -v /path/to/.mongorc.js:/home/mongo/.mongorc.js \
    casperfrx/mongodb-shell <MongoDB Access URL>
```

If no MongoDB server URL is given, the command falls back to the `--help` CLI argument..

## (Optional): Add to .bashrc / profile
To run the container as if it was a native command, add this line to `.bashrc/.profile`:

```bash
alias mongo="docker run -it --rm -v /path/to/data:/data -v /path/to/.mongorc.js:/home/mongo/.mongorc.js --user $(id -u):$(id -g) casperfrx/mongodb-shell"

```

Now you can just run:
```bash
mongo <MongoDB Access URL>
```


