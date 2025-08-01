# edge-picamera-image
Trovi artifact detailing how to use the libcamera driver stack
on CHI@Edge.

Provides a Jupyter Notebook, Dockerfile, and example python code.

The Dockerfile packages minimal dependencies for libcamera libraries, picamera2
libcamera bindings, and libcamera cli applications. Due to installing from the 
raspberry pi maintained apt repo, we no longer need manual compilation of these deps.

For further details, please refer to the Raspberry Pi Camera documentation:
https://www.raspberrypi.com/documentation/computers/camera_software.html

For proper functionality, libcamera requires access to the following devices
under /dev inside the container. In CHI@Edge, this is provided by the 
"pi_libcamera" device profile.

video* device nodes are  documented here: https://www.raspberrypi.com/documentation/computers/camera_software.html#device-nodes-when-using-libcamera

- `dma_heap`: required for contiguous memory allocation used for capture buffers
- `media[0:4]`
- `v4l-subdev0`
- `vchiq`
- `vcsm-cma`
- `video[10:16]`
- `video[18:23]`
- `video31`

In order for all of these devices to appear, the following /boot/config.txt
options must be specified.

- camera_auto_detect=1  # enables automatic loading of correct dtoverlay
- start_x=0             # default, ensures legacy camera stack does not load

And, `gpu_mem` must *not* be set, or if set, be at least 128 or the camera
stack will not start.

For the picamera3 (imx708) to be auto-detected, a relatively recent OS version
is needed. BalenaOS version 6.5.42+rev2 with kernel 6.12.32-v8 is known to work.

Finally, libcamera requires read-only access to `/run/udev` to enumerate 
available cameras. This is also provided by CHI@Edge, but can be accomplished 
manually via 

`docker run -v /run/udev:/run/udev:ro`
