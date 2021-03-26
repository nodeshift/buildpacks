# Node.js Build Packs 

WIP build pack to use Red Hat Node.js ubi images.

Current usage is as outlined in the sections which follow.


## Ensure docker or podman is installed

If these are not already installed, install docker or podman
based on the process for your operating system.

## Install Pack

Buildpacks depend on Pack. Install following the instructions
here: https://buildpacks.io/docs/tools/pack/


## Prepare ubi images

Build packs require additional metadata that does not yet exist
on the Red Hat ubi images. We are currently working to add
this metadata to the ubi images. Once added this step will
no longer be necessary.

To create images with the required metadata do the following:

* cd temp_image
* execute `bash fixup-image.sh X Y` where X is the ubi version
  you want to use and Y is the Node.js version you want to use.
  For example `bash fixup-image.sh 8 12`
* cd ..

You will now have an an image with the postfix `-fixed` that
has the additional metadata. For example:

```bash
user1@user1-VirtualBox:~/demos/buildpacks$ docker images
REPOSITORY                                        TAG                   IMAGE ID            CREATED             SIZE
registry.access.redhat.com/ubi8/nodejs-12-fixed   latest                7582da2ae077        16 minutes ago      776MB
```

## Create builder

To create the builder that will include the buildpack
do the following:

* cd builders
* execute `bash create.sh X Y -fixed` where X is the ubi version
  you want to use and Y is the Node.js version you want to use.
  For example `bash create.sh 8 12 -fixed`. You must have
  prepared a matching image in the step above.

The output of this step will be a message that tells you
how to run the builder which includes the build pack. For
example:

```bash
user1@user1-VirtualBox:~/demos/buildpacks/builders$ bash create.sh 8 12 -fixed
Successfully created builder image nodejs-12_ubi-8_builder
Tip: Run pack build <image-name> --builder nodejs-12_ubi-8_builder to use this builder
```

## Use the builder/buildpack

Run the command line suggested by the output of creating the
builder in an application directory with a `package.json` file.

For example using the nodejs-rest-http  nodeshift-starter :

* git clone https://github.com/nodeshift-starters/nodejs-rest-http.git
* cd nodejs-rest-http
* pack build test-image --builder nodejs-12_ubi-8_builder
* docker run -p 8080:8080 -d -t test-image

The nodejs-rest-http nodeshift-starter will now be running and you
can access it at http://localhost:8080



