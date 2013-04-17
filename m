From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Apr 2013 15:12:03 +0100
Subject: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130417141202.GT13687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 01:42:44PM +0200, Markus Pargmann wrote:

> This series adds DT support for phycore-ac97. It is now based on the pcm dma
> cleanups from Lars. Beside ac97 support, the series adds fsl-ssi imx-pcm-fiq
> and generic DMA binding handling.

I've now merged the core and i.MX bits of that into topic/dma so if you
could check what actually went in and then respin?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130417/a1b6da93/attachment.sig>
