From: J.Lambrecht@televic.com (=?ISO-8859-1?Q?J=FCrgen_Lambrecht?=)
Date: Wed, 16 Feb 2011 09:58:34 +0100
Subject: newbie question: location of frame buffer driver for imx27
Message-ID: <4D5B91BA.9090306@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

we have the Freescale IMX27-PDK demo kit. Along with it, we got the 
source code for the linux kernel version 2.6.22, and a lot of patches.
Also for the video part, there are a lot of patches, creating a 
/drivers/video/mxc subdirectory.
In the linux sources 2.6.37, I only find 2 files: mx3fb.c (imx3x i 
guess) and imxfb.c.
When we try to compile linux for the imx27 (with the latest ltib) there 
are no framebuffers under devices.

Do I still need to patch linux/drivers/video for the imx27, or should it 
work fine like it is?
(and if so, what do I do wrong ;-)

Kind regards,
Juergen

-- 
J?rgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
