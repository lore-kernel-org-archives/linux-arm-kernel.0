From: s.hauer@pengutronix.de (MXC Sascha Hauer)
Date: Wed, 19 May 2010 14:23:16 +0200
Subject: [PATCH 0/2 v2] MX3X: Architecture specific mx3 keypad support
In-Reply-To: <1274261512.3123.6.camel@realization>
References: <1274261512.3123.6.camel@realization>
Message-ID: <20100519122316.GP31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 11:31:52AM +0200, Alberto Panizzo wrote:
> This two patches add the support for the keypad device
> over the recent merge of the imx-keypad driver and shows
> how to support this device into the machine file.
> 
> v2: Pin definition helpers are placed in iomux-mx3.h
> 
> Alberto Panizzo (2):
>   MX3X: Add Keypad device definition for MX3X arch
>   mx31_3ds: Support the keypad situated in the personality board
> 
>  arch/arm/mach-mx3/devices.c                |   19 ++++++++++++++++
>  arch/arm/mach-mx3/devices.h                |    1 +
>  arch/arm/mach-mx3/mach-mx31_3ds.c          |   32 ++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/iomux-mx3.h |   17 ++++++++++++++

Ok, applied.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
