From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 3 Aug 2012 09:04:58 +0800
Subject: [PATCH 0/4] dmaengine: add support mmp-pdma
In-Reply-To: <1343364382-16269-1-git-send-email-zhangfei.gao@marvell.com>
References: <1343364382-16269-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <CAMj5Bkjy4w76h2Mh3zMRwzjczSXRkTOya87_U=zTLZrYLuLxhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 12:46 PM, Zhangfei Gao <zhangfei.gao@marvell.com> wrote:
> v0->v1
> Update dt member and desc according to Arnd's suggestion
> Use dma_slave_config.slave_id to transfer drcmr followed Vinod's suggestion
>
> Patch 4 is upload as example
> mtd: pxa3xx-nand: replace pxa_request_dma with dmaengine
> We would like hold this patch currently
> since pdma will grab irq and disable pxa_init_dma.
>
> Any attempt of replacing pxa_request_dma with dmaengine on pxa3xx platform are welcome
> Here are many replacing and verifying work to do.
>
>
> mmp-pdma is added under dmaengine framework.
> The final purpose is replacing arch/arm/plat-pxa/dma.c
>
> Test on pxa910 with pxa3xx-nand and dmatest.ko
>
> Zhangfei Gao (4):
>   dmaengine: mmp-pdma support
>   dmaengine: mmp_tdma: add dt support
>   dmatest: add dmaengine_slave_config for DMA_MEMCPY

Hi, Arnd & Vinod

Would you mind taking look at the updated mmp-pdma patch, thanks for the help.
