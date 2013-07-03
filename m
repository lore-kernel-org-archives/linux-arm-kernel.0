From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 17:19:00 +0100
Subject: [PATCH v9 10/10] ASoC: fsl: Update fsl-ssi binding doc
In-Reply-To: <1371734429-6081-11-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-11-git-send-email-mpa@pengutronix.de>
Message-ID: <20130703161900.GU27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 03:20:29PM +0200, Markus Pargmann wrote:
> Update the fsl-ssi bindings. DMA is no required property anymore and
> uses the generic DMA bindings. imx-fiq is a new alternative to DMA

These updates should be done as part of the patches making the code
changes - see the review comment I had earlier for an example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/7c482336/attachment.sig>
