From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Sep 2011 13:04:28 -0300
Subject: gpio_ensure_requested error on mx31pdk boot
In-Reply-To: <20110915071427.GD11297@pengutronix.de>
References: <CAOMZO5AmM2yd5FopjNO9QsPNLZiBNH3U29_xXPV3cnZnB9EjtQ@mail.gmail.com>
	<20110915071427.GD11297@pengutronix.de>
Message-ID: <CAOMZO5DcPCVy9uMXPXd3Kmam1XcCjYPcEU_O8pvy2uhM17eseQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/15 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
> I havn't seen it. Just in case you don't know, that means a gpio was
> used without being (successfully) requested. On the other hand I wonder
> if GPIO-0 is correct here?!

I managed to fix this. It is a bug in the spi-imx driver. Patch will
be sent shortly.

Regards,

Fabio Estevam
