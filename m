From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 17:11:58 +0800
Subject: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
In-Reply-To: <cover.1383226444.git.b42378@freescale.com>
References: <cover.1383226444.git.b42378@freescale.com>
Message-ID: <20131101091156.GC10324@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolin,

The dmaengine maintainer Vinod Koul should be copied on the series.
(Just added).

On Thu, Oct 31, 2013 at 09:44:12PM +0800, Nicolin Chen wrote:
> Nicolin Chen (4):
>   dma: imx-sdma: Add sdma firmware version 2 support
>   dma: imx-sdma: Add new dma type for ssi dual fifo script
>   ASoC: fsl_ssi: Add dual fifo mode support
>   ARM: dts: imx: use dual-fifo sdma script for ssi

Vinod,

To keep git bisect, the series has to be merged through single tree.
Since Mark has ACK-ed patch #3, I think it's easier to merge the series
through your tree, so for patch #4:

Acked-by: Shawn Guo <shawn.guo@linaro.org>
