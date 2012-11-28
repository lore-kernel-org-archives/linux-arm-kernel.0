From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 28 Nov 2012 16:08:51 +0100
Subject: [PATCH] add hardware I2C support for ARM IMX23
In-Reply-To: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
References: <20121128152403.45224dvyaufb1j7n@62.129.139.42>
Message-ID: <20121128150851.GA4659@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 03:24:03PM +0100, sander van ginkel wrote:
> The I2C hardware in the IMX233 is currently not supported,
> however the i2c-mxs driver seems to be suitable.
> To use the i2c-mxs driver it has to be added to the devicetree
> for the IMX23.

Have you tested it? There have been problems reported when using
i2cdetect...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/e64fb55d/attachment.sig>
