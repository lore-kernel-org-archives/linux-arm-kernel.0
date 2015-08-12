From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 11:25:50 +0100
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812102550.GQ10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:27PM +0200, Markus Pargmann wrote:
> Regmap does not support 64bit. The ival that is used to write the 64bit
> data to, is unsigned int and can't hold 64bit. _regmap_write also just
> supports unsigend int.

What makes you say that unsigned int can't hold 64 bit?  An architecture
can have 64 bit ints if it likes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/055cdde2/attachment-0001.sig>
