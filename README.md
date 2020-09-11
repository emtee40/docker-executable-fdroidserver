For people already setup with Docker, this is a very easy way to run
the _fdroidserver_ tools for managing F-Droid repos and building apps.
It does not include a full Android SDK, so if you want to use the full
Android SDK with this image, you'll need to mount your own local copy.

It can be run using (local user must have access to .cache):

```console
$ docker run --rm -u $(id -u):$(id -g) -v $(pwd):/repo registry.gitlab.com/fdroid/docker-executable-fdroidserver:master
```

### Examples (with Android SDK and as root):

Docker must have access to the android sdk folder as well as the fdroiddata repo folder.

Init your fdroiddata repo (creates config.py in your fdroiddata repo):
```console
cd {your copy of fdroiddata repo}
docker run --rm -v {path to your android sdk}:/opt/android-sdk -v $(pwd):/repo -e ANDROID_HOME:/opt/android-sdk registry.gitlab.com/fdroid/docker-executable-fdroidserver:master init -v
```

Lint your apps metadata file:
```console
cd {your copy of fdroiddata repo}
docker run --rm -v {path to your android sdk}:/opt/android-sdk -v $(pwd):/repo -e ANDROID_HOME:/opt/android-sdk registry.gitlab.com/fdroid/docker-executable-fdroidserver:master lint {your app id} -v
```

Optimize your metadata file:
```console
cd {your copy of fdroiddata repo}
docker run --rm -v {path to your android sdk}:/opt/android-sdk -v $(pwd):/repo -e ANDROID_HOME:/opt/android-sdk registry.gitlab.com/fdroid/docker-executable-fdroidserver:master rewritemeta {your app id} -v
```

Build your app:
```console
cd {your copy of fdroiddata repo}
docker run --rm -v {path to your android sdk}:/opt/android-sdk -v $(pwd):/repo -e ANDROID_HOME:/opt/android-sdk registry.gitlab.com/fdroid/docker-executable-fdroidserver:master build {your app id}:{your app version as integer} -v
```