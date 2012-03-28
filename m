From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 12:07:36 +0100
Subject: [PATCH] ASoC: fsl: assign dma peripheral type according to bus
 topology
In-Reply-To: <1332920096-9701-1-git-send-email-shawn.guo@linaro.org>
References: <1332920096-9701-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120328110735.GL3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 03:34:56PM +0800, Shawn Guo wrote:
> The dma peripheral_type for SSI should be IMX_DMATYPE_SSI_SP if the SSI
> is on SPBA bus.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/4f3d3b24/attachment.sig>
