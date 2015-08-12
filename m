From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:52:56 +0200
Subject: [PATCH 17/20] iio: bmc150: Use i2c regmap
In-Reply-To: <20150812120146.GD10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
 <20150812120146.GD10748@sirena.org.uk>
Message-ID: <20150812125256.GL19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:01:46PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:42PM +0200, Markus Pargmann wrote:
> 
> > +	select REGMAP
> > +	select REGMAP_I2C
> 
> You don't need to select regmap, only REGMAP_I2C.

Ok, thanks, will fix.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/02310db8/attachment.sig>
