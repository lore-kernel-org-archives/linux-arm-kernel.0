From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Mar 2011 08:26:57 +0100
Subject: A few mxsfb patches
In-Reply-To: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110307072657.GF29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sun, Mar 06, 2011 at 12:18:48AM +0800, Shawn Guo wrote:
> The patches came from the work of adding framebuffer for mx28evk and
> mx23evk boards.  They are all minor changes.
> 
>  [PATCH 1/3] video: mxsfb: smarten the code a little bit
>  [PATCH 2/3] video: mxsfb: fix the incorrect error checking for alloc_pages_exact
>  [PATCH 3/3] video: mxsfb: add DOTCLK polarity configuration support

As this driver is new, we can squash these patches into the original
patch and add your ack to this one, if that's ok for you.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
