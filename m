From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 18 May 2016 07:46:43 +0000
Subject: [PATCH] dmaengine: vdma: Add support for cyclic dma mode
In-Reply-To: <1463221231-30374-1-git-send-email-appanad@xilinx.com>
References: <1463221231-30374-1-git-send-email-appanad@xilinx.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5968D1@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  };
> 
> @@ -474,6 +481,7 @@ xilinx_vdma_alloc_tx_segment(struct xilinx_dma_chan
> *chan)
>  	if (!segment)
>  		return NULL;
> 
> +	memset(segment, 0, sizeof(*segment));

Unrelated change will fix in v2...

>  	segment->phys = phys;
> 
>  	return segment;
