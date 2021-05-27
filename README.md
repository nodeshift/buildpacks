# Node.js Build Packs 

WIP build pack to use Red Hat Node.js ubi images.

Current usage is as outlined in the sections which follow.


## Ensure docker or podman is installed

If these are not already installed, install docker or podman
based on the process for your operating system.

## Install Pack

Buildpacks depend on Pack. Install following the instructions
here: https://buildpacks.io/docs/tools/pack/


## Suitable build images

Currently only the ubi8/Nodejs-14 and ubi8/Nodejs-14-minimal
images have the required metadata and are suitable for use
with the build pack. You could use it with other images,
but you would have to build those yourself and add
the required buildpack metadata.

## Create builder

To create the builder that will include the buildpack
do the following:

* cd builders
* execute `bash create.sh X Y -fixed` where X is the ubi version
  you want to use and Y is the Node.js version you want to use.
  (As noted currently this should only be ubi 8 and Node.js 14)
  For example `bash create.sh 8 14`. You must have
  prepared a matching image in the step above.

The output of this step will be a message that tells you
how to run the builder which includes the build pack. For
example:

```bash
user1@user1-VirtualBox:~/demos/buildpacks/builders$ bash create.sh 8 14
Successfully created builder image nodejs-14_ubi-8_builder
Tip: Run pack build <image-name> --builder nodejs-14_ubi-8_builder to use this builder
```

## Use the builder/buildpack

Run the command line suggested by the output of creating the
builder in an application directory with a `package.json` file.

For example using the nodejs-rest-http  nodeshift-starter :

* git clone https://github.com/nodeshift-starters/nodejs-rest-http.git
* cd nodejs-rest-http
* pack build test-image --builder nodejs-14_ubi-8_builder
* docker run -p 8080:8080 -d -t test-image

The nodejs-rest-http nodeshift-starter will now be running and you
can access it at http://localhost:8080



