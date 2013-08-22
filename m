From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 11:11:32 +0100
Subject: [PATCH v11 8/8] ASoC: fsl: disable ssi irq for imx
In-Reply-To: <1376924761-4054-9-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-9-git-send-email-mpa@pengutronix.de>
Message-ID: <20130822101132.GY26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:06:01PM +0200, Markus Pargmann wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> We have to disable the ssi irq, as it is not safe for all platforms to
> write back into the status register. It also runs into non-linefetch
> aborts.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/2c967024/attachment.sig>
