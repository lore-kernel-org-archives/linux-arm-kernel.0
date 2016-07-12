From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Jul 2016 09:22:56 +0100
Subject: [PATCH v3 6/7] spi: s3c64xx: restore removed comments
In-Reply-To: <1468306444-18512-1-git-send-email-andi.shyti@samsung.com>
References: <57837606.8050906@samsung.com>
 <1468306444-18512-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160712082256.GD9976@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 03:54:04PM +0900, Andi Shyti wrote:
> Patch a9e93e8 has erroneously removed some comments which are
> important to understand why the bus frequency is multiplied by
> two during the spi transfer.

Please don't bury patches in the middle of old threads, it makes it very
confusing trying to figure out what's going on especially when you do
this one patch at a time in a series.  Submit new patches as a complete
series, ideally not threaded in with anything else (at least for me).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160712/e32d1a91/attachment.sig>
