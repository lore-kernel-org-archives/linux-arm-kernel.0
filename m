From: broonie@kernel.org (Mark Brown)
Date: Sun, 16 Feb 2014 09:16:11 +0800
Subject: [PATCH v4 1/2] spi:fsl-dspi:convert to use regmap and big-endian
 supports
In-Reply-To: <1392190146-18852-1-git-send-email-b44548@freescale.com>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
Message-ID: <20140216011611.GU4451@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 03:29:05PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> Freescale DSPI module will have two endianess in different platform,
> but ARM is little endian. So when DSPI in big endian, core in little endian,
> readl and writel can not adjust R/W register in this condition.
> This patch will remove general readl/writel, and import regmap mechanism.
> Data endian will be transfered in regmap APIs.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140216/f022e2e9/attachment.sig>
