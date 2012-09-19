From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Sep 2012 10:45:30 +0800
Subject: [PATCH v3 04/15] dmaengine: Pass flags via
 device_prep_dma_cyclic() callback
In-Reply-To: <1347624358-25582-5-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120919024528.GA6460@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 03:05:47PM +0300, Peter Ujfalusi wrote:
> Change the parameter list of device_prep_dma_cyclic() so the DMA drivers
> can receive the flags coming from clients.
> This feature can be used during audio operation to disable all audio
> related interrupts when the DMA_PREP_INTERRUPT is cleared from the flags.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Barry Song <baohua.song@csr.com>
> CC: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
> CC: Vista Silicon <javier.martin@vista-silicon.com>
> CC: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Laxman Dewangan <ldewangan@nvidia.com>
> ---
...
>  drivers/dma/imx-dma.c         | 2 +-
>  drivers/dma/imx-sdma.c        | 2 +-
...
>  drivers/dma/mxs-dma.c         | 2 +-

Acked-by: Shawn Guo <shawn.guo@linaro.org>
