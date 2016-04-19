From: dennis@ausil.us (Dennis Gilmore)
Date: Tue, 19 Apr 2016 13:34:23 -0500
Subject: bug in autoloading of imx-ipuv3-crtc
Message-ID: <6926808.b0joqYQPQE@anubis.ausil.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

on all of my i.MX6 systems imx-ipuv3-crtc ius not getting automatically 
loaded.  Everything is built as a module

CONFIG_DRM_IMX=m
CONFIG_DRM_IMX_FB_HELPER=m
CONFIG_DRM_IMX_HDMI=m
CONFIG_DRM_IMX_IPUV3=m
CONFIG_DRM_IMX_LDB=m
CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
CONFIG_DRM_IMX_TVE=m
CONFIG_IMX_IPUV3_CORE=m

The result is that until I log in via serial or ssh and modprobe the module 
there is no display.  I suspect that there is some devicetree glue missing 4.4 
and 4.5 seem to both be effected.

Dennis
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/433e0e1d/attachment.sig>
