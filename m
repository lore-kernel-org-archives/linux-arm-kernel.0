From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 17:19:33 +0000
Subject: [PATCH v4 4/9] ASoC: fsl-ssi: Fix interrupt stats for imx
In-Reply-To: <1387545096-2334-5-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20140108171933.GO31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:11:31PM +0100, Markus Pargmann wrote:
> irqs should only be requested/released with enabled DMA. Previously
> interrupt statistics where disabled for IMX Processors because of
> different writeable SISR bits.
> 
> This patch introduces support for irqstats on imx processors again by
> creating a sisr writeback mask and introducing a imx35-ssi compatible.

A binding documentation update is needed for this too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/0ec38ab2/attachment.sig>
