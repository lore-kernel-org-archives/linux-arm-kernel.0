From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 24 May 2010 12:23:41 +0200
Subject: i.MX27 GPIOs -- how to define the default output?
In-Reply-To: <20100522010210.GA18017@www.longlandclan.yi.org>
References: <20100522010210.GA18017@www.longlandclan.yi.org>
Message-ID: <20100524102341.GK28820@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 11:02:17AM +1000, Stuart Longland wrote:
> I'm in the process of porting Ka-Ro's TX27 kernel patch over from
> kernel 2.6.28 to current git HEAD[1]. In the process of doing this, I
> note that the old definitions GPIO_DFLT_HIGH and GPIO_DFLT_LOW have
> disappeared.
>
> I can't seem to find their replacements anywhere.

Check for example mach-pcm038.c, it shows how to do the pin setup.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
