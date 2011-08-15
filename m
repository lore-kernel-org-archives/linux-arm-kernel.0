From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Aug 2011 17:48:54 +0200
Subject: [PATCH] backlight: Fix broken regulator API usage in l4f00242t03
In-Reply-To: <20110815130619.GB3927@opensource.wolfsonmicro.com>
References: <1313372500-28017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110815064242.GR31404@pengutronix.de>
	<20110815130619.GB3927@opensource.wolfsonmicro.com>
Message-ID: <20110815154854.GT31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 10:06:22PM +0900, Mark Brown wrote:
> On Mon, Aug 15, 2011 at 08:42:42AM +0200, Sascha Hauer wrote:
> 
> > Maybe you could change these pr_err to dev_err on the way. The rest of
> > the driver already uses dev_*.
> 
> Minimal diff and all that...

It just came to my mind because you touch the lines anyway, but I'm fine
with the posted version aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
