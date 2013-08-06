From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Aug 2013 17:59:02 +0100
Subject: [PATCH v10 4/7] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1374924716-23475-5-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20130806165902.GI6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 01:31:53PM +0200, Markus Pargmann wrote:
> Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
> Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
> and the SIER flags are set differently.

Applied, thanks.  Ideally we'd have a quirk infrastructure to figure out
if this is required but it really doesn't seem worth it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/9e120bde/attachment.sig>
