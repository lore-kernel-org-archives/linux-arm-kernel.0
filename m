From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Feb 2011 13:27:36 -0200
Subject: newbie question: location of frame buffer driver for imx27
In-Reply-To: <4D5B91BA.9090306@televic.com>
References: <4D5B91BA.9090306@televic.com>
Message-ID: <AANLkTi=9ReeZMxEWn=-aor55tPdTsV=Oi=6EsbmbHGv2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rgen,

2011/2/16 J?rgen Lambrecht <J.Lambrecht@televic.com>:
> Hello,
>
> we have the Freescale IMX27-PDK demo kit. Along with it, we got the source
> code for the linux kernel version 2.6.22, and a lot of patches.
> Also for the video part, there are a lot of patches, creating a
> /drivers/video/mxc subdirectory.
> In the linux sources 2.6.37, I only find 2 files: mx3fb.c (imx3x i guess)
> and imxfb.c.
> When we try to compile linux for the imx27 (with the latest ltib) there are
> no framebuffers under devices.
>
> Do I still need to patch linux/drivers/video for the imx27, or should it
> work fine like it is?
> (and if so, what do I do wrong ;-)

Framebuffer support for MX27 is available at: drivers/video/imxfb.c

You can also take a look at arch/arm/mach-imx/mach-mx27ads.c to see an
example of a MX27 based board with framebuffer support.

Regards,

Fabio Estevam
