From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Feb 2016 14:22:37 +0000
Subject: [PATCH 03/13] spi: imx: replace fixed timeout with calculated
In-Reply-To: <1455715739-25161-4-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <1455715739-25161-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160217142237.GS7544@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 02:28:49PM +0100, Sascha Hauer wrote:
> From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
> 
> Fixed timeout value can fire while transaction is ongoing. This may happen
> because there are no strict requirements on SPI transaction duration.
> Dynamic timeout value is generated based on SCLK and transaction size.
> 
> There is also 4 * SCLK delay between TX bursts related to HW internal CS change.
> 
> Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
> ---

I can't take this without a signoff from you, sorry - the DCO is very
imporant here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/acd043d2/attachment.sig>
