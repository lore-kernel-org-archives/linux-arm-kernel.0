From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 13 Jun 2016 05:37:54 +0000
Subject: [PATCH] dmaengine: vdma: Fix compilation warning in cyclic dma
 mode
In-Reply-To: <20160613054243.GB16910@localhost>
References: <1465452132-13512-1-git-send-email-appanad@xilinx.com>
 <20160613054243.GB16910@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5B5E4F@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> On Thu, Jun 09, 2016 at 11:32:12AM +0530, Kedareswara rao Appana wrote:
> > This patch fixes the below compilation warining.
> > drivers/dma/xilinx/xilinx_vdma.c: In function 'xilinx_dma_prep_dma_cyclic':
> > drivers/dma/xilinx/xilinx_vdma.c:1808:23: warning: 'segment' may be
> > used uninitialized in this function [-Wmaybe-uninitialized]
> >    segment->hw.control |= XILINX_DMA_BD_SOP;
> >
> > The start of packet (SOP) should be set to the first segment in the
> > desc chain not for the last segment of the desc chain.
> 
> I have applied this after adding Reported by from SFR.

Sorry will fix it next time on wards....

> 
> You should always give credit to folks who report issues.

Sure will fix next time onwards...

Thanks,
Kedar.
