From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Mar 2012 15:34:38 +0000
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229194409.GO14173@pengutronix.de>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org>
 <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
Message-ID: <20120301153438.GA16916@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 08:44:09PM +0100, Uwe Kleine-K?nig wrote:

> If you want to give incentive for U-Boot to improve, drop the target
> today. And note that at least people caring about boot time must not use
> the kernel's uImage target anyhow.

It's not just u-boot, at least Qi also uses uImage (I'm stuck with it on
one platform and don't currently have the time/enthusiasm to fix either
the bootloader selection or the zImage support).
