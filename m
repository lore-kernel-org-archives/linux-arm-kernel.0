From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Jan 2012 20:02:50 +0100
Subject: Common clock API for i.MX
In-Reply-To: <20120126062004.GB2287@S2101-09.ap.freescale.net>
References: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
 <20120125084533.GD1068@n2100.arm.linux.org.uk>
 <20120126062004.GB2287@S2101-09.ap.freescale.net>
Message-ID: <20120126190250.GP5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 02:20:05PM +0800, Shawn Guo wrote:
> On Wed, Jan 25, 2012 at 08:45:33AM +0000, Russell King - ARM Linux wrote:
> > Grepping for clk_prepare() it looks like very few people have converted
> > over to this - it's just the AMBA stuff, a few bits of OMAP and MXS.
> 
> Sascha queued up some of IMX clk_prepare() bits from Richard Zhao on
> branch below.
> 
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/imx-features
> 
> Sascha, what's the plan of mainlining them?  I thought you could have
> sent them during 3.3 merge window.  But you did not.

Grmpf. Seems I have missed the patches. My bad. I will see if they
still merge and send a pull request tomorrow.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
