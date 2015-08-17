From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 17 Aug 2015 10:00:17 +0200
Subject: [PATCH 20/20] iio: bmc150: Add SPI driver
In-Reply-To: <20150812120300.GE10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
 <20150812120300.GE10748@sirena.org.uk>
Message-ID: <20150817080017.GM19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:03:00PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:45PM +0200, Markus Pargmann wrote:
> 
> > +	.use_single_rw = false,
> > +	.cache_type = REGCACHE_NONE,
> > +};
> 
> No need to initialise defaults.

Thanks, removed those.

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150817/4c203c2c/attachment.sig>
