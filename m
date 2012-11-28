From: sander@van-ginkel.eu (sander van ginkel)
Date: Wed, 28 Nov 2012 17:10:39 +0100
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <20121128150851.GA4659@pengutronix.de>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
Message-ID: <20121128171039.14705ltphptrp5kv@62.129.139.42>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Citeren "Wolfram Sang" <w.sang@pengutronix.de>:

> Have you tested it? There have been problems reported when using
> i2cdetect...
>
> --
> Pengutronix e.K.                           | Wolfram Sang
      |
> Industrial Linux Solutions                 |
http://www.pengutronix.de/  |
>

I've tested it with multiple configs.
i2cdetect -l gives me:
i2c-0   i2c             MXS I2C adapter                         I2C adapter
