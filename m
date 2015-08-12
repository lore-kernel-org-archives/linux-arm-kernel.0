From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 13:03:00 +0100
Subject: [PATCH 20/20] iio: bmc150: Add SPI driver
In-Reply-To: <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812120300.GE10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:45PM +0200, Markus Pargmann wrote:

> +	.use_single_rw = false,
> +	.cache_type = REGCACHE_NONE,
> +};

No need to initialise defaults.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/f0330e21/attachment.sig>
