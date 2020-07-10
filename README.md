# Vagrant

```
vagrant up
```

vagrant image must be created beforehand. See README.md placed in _virtualbox_ directory.

# Docker

## Getting started

```
chmod 600 ssh/authorized_keys
```

```
docker-compose build
docker-compose up -d
```

```
ssh ec2local -F ssh/config
```

## Terminate local amazonlinux

```
docker-compose ps
docker-compose down
```

## Note

```
ssh-keygen -t rsa -b 4096 -C amazonlinux@ec2.com -f ssh/authorized_keys
```
