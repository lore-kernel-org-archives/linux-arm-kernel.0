From: dean_go@eledsn.com (dean_go Zhang)
Date: Fri, 30 Oct 2009 20:28:44 +0800
Subject: Soc camera:Is there anyone dealing with ov9650chip?Let's talk about
	soc camera driver.
Message-ID: <65c69abb0910300528j2bffc2b8i8eb07254725f8de7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm reading to documentation in linux-2.6.30,and ov7670 driver ,and I'm
trying to make a driver for ov9650.

> struct soc_camera_ops provides .probe and .remove methods, which are called
> by
> the soc-camera core, when a camera is matched against or removed from a
> camera
> host bus, .init, .release, .suspend, and .resume are called from the camera
> host
> driver as discussed above. Other members of this struct provide respective
> V4L2
> functionality.
>

This is from the documentation,but I didn't find any thing about
soc_camera_host_device in ov7670's driver code.
Does anyone know how to make a v4l2 soc camera driver?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091030/9d20025c/attachment.htm>
