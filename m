From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 30 Jun 2017 06:13:05 -0700
Subject: [PATCH] dmaengine: zynqmp_dma: fix error return code in
 zynqmp_dma_chan_probe()
In-Reply-To: <20170630074247.GA26153@embeddedgus>
References: <20170630074247.GA26153@embeddedgus>
Message-ID: <20170630131305.ttly7stfqcthfbbx@xsjsorenbubuntu.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-06-30 at 02:42:47 -0500, Gustavo A. R. Silva wrote:
> Print error message and propagate the return value of
> platform_get_irq on failure.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
