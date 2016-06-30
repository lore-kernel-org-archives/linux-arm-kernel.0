From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 30 Jun 2016 05:23:30 +0000
Subject: [PATCH v11 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <20160630042653.GM14945@localhost>
References: <1465486667-30737-1-git-send-email-appanad@xilinx.com>
 <1465486667-30737-2-git-send-email-appanad@xilinx.com>
 <20160630042653.GM14945@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5BA435@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

> 
> On Thu, Jun 09, 2016 at 09:07:47PM +0530, Kedareswara rao Appana wrote:
> 
> > +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
> > +	dma_cap_set(DMA_SG, zdev->common.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
> 
> >  /**
> > + * struct zynqmp_dma_config - ZYNQMP DMA Configuration structure
> > + * @ovrfetch: Overfetch status
> > + * @has_sg: Support scatter gather transfers
> > + * @ratectrl: Rate control value
> > + * @src_issue: Out standing transactions on source
> > + * @src_burst_len: Source burst length
> > + * @dst_burst_len: Dest burst length
> > + */
> 
> As discussed in other thread as well, this is no-go for memcpy. Please come back
> after removing this
> 
> For slave usages use the dma_slave_config

Sure will fix in the next version...

Regards,
Kedar.

> 
> --
> ~Vinod
