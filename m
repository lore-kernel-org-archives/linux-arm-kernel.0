From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 17:02:18 +0100
Subject: [PATCH v9 01/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130703160218.GO27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 03:20:20PM +0200, Markus Pargmann wrote:
> This patch removes the NO_DT flag. The pdev pointer may have a proper
> of_node with the dmas property, so we can use it to request DMA
> channels.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/88ac9765/attachment.sig>
