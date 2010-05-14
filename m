From: david.woodhouse@intel.com (David Woodhouse)
Date: Fri, 14 May 2010 09:35:19 +0100
Subject: [PATCH 11/20] mtd: pxa3xx_nand: add debug messege
In-Reply-To: <4BED07BD.7090403@pengutronix.de>
References: <AANLkTilMUQHJDzVrO5FXeEE8udXkDwS240Vrl1lIkdyG@mail.gmail.com>
	<4BED07BD.7090403@pengutronix.de>
Message-ID: <1273826119.9999.1634.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-14 at 09:20 +0100, Marc Kleine-Budde wrote:
> 
> If you really need to get this in mainline, try using pr_debug() for
> this, add
> 
> #if PXA3XX_NAND_DEBUG
> #define DEBUG
> #endif
> 
> to activate debugging. 

I _wish_ we could have a per-device 'debug' flag, and dev_dbg() would
work based on that. We should also be able to compile it out completely,
of course.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
