From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Sep 2011 15:27:59 -0300
Subject: [PATCH] spi/imx: Fix spi-imx when the hardware SPI chipselects
	are used
In-Reply-To: <20110915181707.GC29357@pengutronix.de>
References: <1316103406-16401-1-git-send-email-fabio.estevam@freescale.com>
	<20110915181707.GC29357@pengutronix.de>
Message-ID: <CAOMZO5DdXke9UyNnM2q2As1vJP0y9Ymug8neUTBDqbaR=00fvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/15 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
> I think this is wrong. My first guess is you need to move
>
> ? ? ? ?spi_imx->chipselect[i] = cs_gpio;
>
> before
>
> ? ? ? ?if (cs_gpio < 0)
> ? ? ? ? ? ? ? ?continue;
>
> Does that make sense and works?

Yes, I was about to send a v2 even prior to getting your email.

Thanks,

Fabio Estevam
