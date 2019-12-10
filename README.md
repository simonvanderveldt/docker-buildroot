# Buildroot Docker images
This repository contains Docker images for [buildroot](http://buildroot.org/).

Note that some patches are applied to the buildroot sources.
For more details about these patches check the `./patches` directory.


## How to use
This buildroot image should be used according to the buildroot [documentation about "Keeping customizations outside of Buildroot"](http://buildroot.org/downloads/manual/manual.html#outside-br-custom).

Create a directory containing your buildroot customizations, for example:
```
+-- board/
|   +-- <company>/
|       +-- <boardname>/
|           +-- linux.config
|
+-- configs/
|   +-- <boardname>_defconfig
|
+-- package/
|   +-- <company>/
|       +-- package1/
|       |    +-- Config.in
|       |    +-- package1.mk
|       +-- package2/
|           +-- Config.in
|           +-- package2.mk
|
+-- Config.in
+-- external.desc
+-- external.mk
```

To use your configuration with the buildroot image use a volume mount to mount the directory inside the container and set the `BR2_EXTERNAL` environment variable to the directory name inside the container. For example:
```
docker run -ti -e BR2_EXTERNAL=/mycustombuildroot -v `pwd`:/mycustombuildroot simonvanderveldt/buildroot:2019.02.8
```

Now you can issue your regular buildroot commands, like `make menuconfig` or `make <boardname>_defconfig` followed by `make`.
