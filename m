From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 28 Nov 2012 17:24:52 +0100
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <20121128171039.14705ltphptrp5kv@62.129.139.42>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
 <20121128150851.GA4659@pengutronix.de>
 <20121128171039.14705ltphptrp5kv@62.129.139.42>
Message-ID: <20121128162452.GB4659@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I've tested it with multiple configs.

Please specify a bit more what you tested and what configs mean. It is
especially important to talk to slaves since this is where DMA problems
occured.

> i2cdetect -l gives me:
> i2c-0   i2c             MXS I2C adapter                         I2C adapter

'i2cdetect -r ...' would be more interesting to see communication with
slaves happening :) Also, what kernel did you test?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/dfe84d0f/attachment.sig>
