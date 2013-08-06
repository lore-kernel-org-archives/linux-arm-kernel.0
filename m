From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Aug 2013 17:59:43 +0100
Subject: [PATCH v10 5/7] ASoC: fsl-ssi: Use generic DMA bindings if
 possible
In-Reply-To: <1374924716-23475-6-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130806165943.GJ6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 01:31:54PM +0200, Markus Pargmann wrote:
> There may be some platforms using fsl-ssi that do not have a DMA driver
> with generic DMA bindings. So this patch adds support for the generic
> DMA bindings, while still accepting the old "fsl,dma-events" property if
> "dmas" is not found.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/80ee4959/attachment.sig>
