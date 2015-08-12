From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 13:35:37 +0100
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <20150812122856.GF19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
 <20150812105758.GU10748@sirena.org.uk>
 <20150812122856.GF19600@pengutronix.de>
Message-ID: <20150812123537.GH10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 02:28:56PM +0200, Markus Pargmann wrote:

> Ok, would work for me as well although sizeof is not a preprocessor
> macro so I would probably leave it as it is. The whole regmap framework
> just didn't seem to support 64bit so I thought this was just not
> working.

I'd expect the framework to cope with things when ints are 64 bit.  We
don't try to support anything else, though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/0cdbdd89/attachment.sig>
