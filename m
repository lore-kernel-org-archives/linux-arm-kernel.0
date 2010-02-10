From: s.hauer@pengutronix.de (Sascha linux-arm)
Date: Wed, 10 Feb 2010 10:47:22 +0100
Subject: When to send patches?
In-Reply-To: <1265758817.2545.123.camel@realization>
References: <1265758817.2545.123.camel@realization>
Message-ID: <20100210094722.GL17643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

On Wed, Feb 10, 2010 at 12:40:17AM +0100, Alberto Panizzo wrote:
> Hi Sascha!
> I have a question: I have to push my work on mach-mx31_3ds machine
> but the entire work need some drivers that are present now in linux-next
> but not in mxc-master.. I have to wait the next merge window or I can push
> the complete mx31_3ds sequence to you adding (or referencing) the dependencies?

Experience showed that compile breakages even temporary are a pain. You
have two possibilities: Either ifdef the code which is causes the
breakage with #ifdef MXC_KEYPAD (or whatever the correct symbol is) so
that the ifdef automaticalle comes true when the driver is there or
just wait until the driver code is merged. So far Russell didn't
complain when the board code for new drivers is merged in -rc1 time. I
prefer the second solution. Just give me a ping when the drivers hit
mainline.

Regards,
  Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
