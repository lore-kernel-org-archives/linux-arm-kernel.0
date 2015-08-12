From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:52:02 +0200
Subject: [PATCH 15/20] regmap-i2c: Add smbus i2c block support
In-Reply-To: <20150812115936.GC10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-16-git-send-email-mpa@pengutronix.de>
 <20150812115936.GC10748@sirena.org.uk>
Message-ID: <20150812125202.GK19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:59:37PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:40PM +0200, Markus Pargmann wrote:
> 
> > +	if (count < 1 || count >= I2C_SMBUS_BLOCK_MAX)
> > +		return -EINVAL;
> 
> Elsewhere you added returns of -E2BIG if the transfer was too big, why
> not do that here as well?

Sounds good to use E2BIG here as well.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/0c10fb64/attachment.sig>
