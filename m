From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 13:01:46 +0100
Subject: [PATCH 17/20] iio: bmc150: Use i2c regmap
In-Reply-To: <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812120146.GD10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:42PM +0200, Markus Pargmann wrote:

> +	select REGMAP
> +	select REGMAP_I2C

You don't need to select regmap, only REGMAP_I2C.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/5b88d48e/attachment.sig>
