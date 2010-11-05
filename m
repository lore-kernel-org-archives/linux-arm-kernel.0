From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 5 Nov 2010 13:31:44 +0100
Subject: Single binary kernel for all i.MX
In-Reply-To: <20101105122946.GH13530@tarshish>
References: <20101105121800.GV6017@pengutronix.de>
	<20101105122946.GH13530@tarshish>
Message-ID: <20101105123144.GW6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 02:29:46PM +0200, Baruch Siach wrote:
> Hi Sascha,
> 
> On Fri, Nov 05, 2010 at 01:18:00PM +0100, Sascha Hauer wrote:
> > We are talking about a single kernel for longer now, here is something
> > to test for the ones interested:
> > 
> > git://git.pengutronix.de/git/imx/linux-2.6.git imx-single-kernel
> > 
> > Compiling the imx_defconfig will result in a kernel which works
> > i.MX21, i.MX27, i.MX31, i.MX35 and i.MX51 (not tested on i.MX21).
> > i.MX1 does not work mainly because the kernel build will use some ARMv5
> > and later instructions.
> 
> What is blocking i.MX25 from being included?

It is. I just forgot to mention.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
