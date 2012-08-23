From: stigge@antcom.de (Roland Stigge)
Date: Thu, 23 Aug 2012 11:30:54 +0200
Subject: mxc_nand.c on mach-imx/imx53
Message-ID: <5035F84E.3000901@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to know about the current state of mxc_nand.c on imx53, because
I got an error on probe() because the clock that mxc_nand is requesting
is "nfc" but imx53 only defines the clock "mxc_nand".

Even after adjusting the name, probe() couldn't find the clock, so I'm
wondering if mxc_nand.c is supported on imx53 at all because other mx'es
have IMX_HAVE_PLATFORM_MXC_NAND in arch/arm/mach-imx/Kconfig but not imx53.

In a custom board BSP, I found an mxc_nd2.c besides mxc_nand.c but not
in mainline. Are there any plans here?

But maybe I just missed sth. - a hint or link would be very much
appreciated.

Thanks in advance,

Roland
