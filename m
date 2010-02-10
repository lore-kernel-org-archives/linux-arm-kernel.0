From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Feb 2010 11:16:32 +0100
Subject: [PATCHv3 0/7] Initial Freescale i.MX51 SoC support
In-Reply-To: <cover.1265733173.git.amit.kucheria@canonical.com>
References: <cover.1265733173.git.amit.kucheria@canonical.com>
Message-ID: <20100210101632.GM17643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Tue, Feb 09, 2010 at 06:59:48PM +0200, Amit Kucheria wrote:
> (patchset rebased on top of Sascha's tree and trivial fixes made)
> git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> 
> Will you consider merging it now?
> 
> Regards,
> Amit
> 
> This series of patches adds basic support for i.MX5 family to the kernel. This
> is just the bare minimum that brings up the board - sets up the clocks, IO
> with a serial port and timers.
> 
> Features:
> 
>   * Console: Serial console using pre-existing drivers/serial/imx.c
>   * Timer: Timer provided through arch/arm/plat-mxc/time.c
>   * Interrupts: New interrupt controller through arch/arm/plat-mxc/tzic.c
>   * Clocks: Minimal Clock framework to allow board boot up
>   * Defconfigs: mx51_defconfig provided
> 
> Tested on a i.MX51-based Babbage 2.5 board.
> 
> Git:
> 
> repo: git://kernel.ubuntu.com/amitk/mx51-upstream.git mx51-baseport

ok, merged for -next. BTW the correct branch is mx51-baseport-sascha.
This shouldn't happen with the proper use of git request-pull.

Thanks for your work!

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
