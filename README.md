## Test with Docker:

If you have [Docker](https://docs.docker.com/get-docker/) installed on your machine, you can run tests without having a lua interpretter or ruby installed. Just run the following commands:

Build docker image:

```bash
docker build -t forth-test .
```

Run tests:

```bash
docker run -it -v $(pwd):/app forth-test
```
