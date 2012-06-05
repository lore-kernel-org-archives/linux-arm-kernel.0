From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jun 2012 14:48:44 +0200
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCDF8BE.6010509@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
 <4FCDF8BE.6010509@snapgear.com>
Message-ID: <20120605124844.GR30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 10:17:02PM +1000, Greg Ungerer wrote:
> 
> >clkdev
> >provides an abstraction which can map these onto the platform, even if
> >you don't use the generic clk API clkdev is still very useful and will
> >help with a lot of these issues.
> 
> In this specific case I don't know what the ipg or ahb clocks are on iMX
> (Sascha?), but there is nothing equivalent to them in the FEC cores used
> on existing ColdFire CPUs. They seem to be platform specific (iMX) more
> than FEC driver specific.

I am sure the Coldfire FEC also needs clocks to work. Just like Mark
said, they may be not software controllable. The names 'ipg' and 'ahb'
may be i.MX specific though.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
