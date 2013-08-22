From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 11:10:52 +0100
Subject: [PATCH v11 7/8] ASoC: fsl-ssi: imx-pcm-fiq bugfix
In-Reply-To: <1376924761-4054-8-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-8-git-send-email-mpa@pengutronix.de>
Message-ID: <20130822101052.GX26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 05:06:00PM +0200, Markus Pargmann wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> imx-pcm-fiq is checking for TE RE bits, so enable them only if
> necessary.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/3ed78200/attachment-0001.sig>
