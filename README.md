# Automad Docker (LiteSpeed)

An alternative to the [official](https://github.com/automadcms/automad-docker) Docker image for [Automad](https://automad.org) that uses the **LiteSpeed** webserver.

## Using this Image

You can create a container called `mysite` and start it by using the following command:

```bash
docker run -dp 80:8088 \
  -v ./app:/app \
  -e UID=$(id -u)
  --name mysite \
  automad/automad:latest-litespeed
```

This will essentially make your site available at port `80` and mount a directory called `/app` for data persistence. The mount point will have the same `UID` assigned that is used by you on the host machine. This way permissions should work out of the box. A new user account for the Automad dashboard will be created automatically. The account details will be logged by the running container. You can show these logs using the following command:

```bash
docker logs mysite
```

Your can now navigate to [localhost](http://localhost) to view your new site.
