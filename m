From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 1 Nov 2013 17:33:27 +0800
Subject: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
In-Reply-To: <20131101091156.GC10324@S2101-09.ap.freescale.net>
References: <cover.1383226444.git.b42378@freescale.com>
 <20131101091156.GC10324@S2101-09.ap.freescale.net>
Message-ID: <20131101093326.GE28401@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 05:11:58PM +0800, Shawn Guo wrote:
> Nicolin,
> 
> The dmaengine maintainer Vinod Koul should be copied on the series.
> (Just added).
>

Ah, I was careless last night when I sent these patches. My VPN connection
was pretty laggy :( Please forgive me, Vinod.

Thank Shawn for adding for me. Much obliged.

> On Thu, Oct 31, 2013 at 09:44:12PM +0800, Nicolin Chen wrote:
> > Nicolin Chen (4):
> >   dma: imx-sdma: Add sdma firmware version 2 support
> >   dma: imx-sdma: Add new dma type for ssi dual fifo script
> >   ASoC: fsl_ssi: Add dual fifo mode support
> >   ARM: dts: imx: use dual-fifo sdma script for ssi
> 
> Vinod,
> 
> To keep git bisect, the series has to be merged through single tree.
> Since Mark has ACK-ed patch #3, I think it's easier to merge the series
> through your tree, so for patch #4:
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
