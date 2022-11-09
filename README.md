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

No suitable build images exist today with the appropriate
metadata needed for the buildpacks. You will need to
create these images by doing the following:

```bash
cd create-images
bash create-images.sh
```

This will create `fixed` images to which the buildpack
metadata has been added. These images are:

REPOSITORY                                           TAG
ubi8/nodejs-14-fixed                                 latest
ubi8/nodejs-14-minimal-fixed                         latest

## Create builder

To create the builder that will include the buildpack
do the following:

* cd builders
* execute `bash create.sh X Y -fixed` where X is the ubi version
  you want to use and Y is the Node.js version you want to use.
  Currently this should only be ubi 8 and Node.js 14 ie:
  `bash create.sh 8 14 -fixed`. You must have
  prepared a matching image in the step above titled
  `suitable build images`.

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



