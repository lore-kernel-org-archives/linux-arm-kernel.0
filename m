From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 08 Mar 2012 18:19:48 +0530
Subject: [GIT PULL] merge PL330 DMAC driver
In-Reply-To: <077301ccf769$f6ac3750$e404a5f0$%kim@samsung.com>
References: <077301ccf769$f6ac3750$e404a5f0$%kim@samsung.com>
Message-ID: <1331210988.4657.60.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-01 at 14:12 +0900, Kukjin Kim wrote:
> Hi Russell and Vinod,
> 
> Please pull merging dma pl330 driver into drivers/dma/.
> It's time to send this to you, and I think that should be sent to upstream
> via rmk and dma tree together.
> 
> If any problems, please kindly let me know.
> 
> As a note, since there is no regarding samsung stuff here, I don't merge
> this into samsung tree.
Thanks, I have manually merged these tree patches with Jassi Ack.
They should be showing up in my next now.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
> 
>   Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.4-for-vkoul-v3
> 
> Boojin Kim (3):
>       DMA: PL330: Merge PL330 driver into drivers/dma/
>       DMA: PL330: Removes useless function
>       DMA: PL330: Support MEMTOMEM transmit w/o RMB, WMB
> 
>  arch/arm/common/Kconfig               |    3 -
>  arch/arm/common/Makefile              |    1 -
>  arch/arm/common/pl330.c               | 1959
> -------------------------------
>  arch/arm/include/asm/hardware/pl330.h |  217 ----
>  drivers/dma/Kconfig                   |    1 -
>  drivers/dma/pl330.c                   | 2089
> ++++++++++++++++++++++++++++++++-
>  include/linux/amba/pl330.h            |    1 -
>  7 files changed, 2088 insertions(+), 2183 deletions(-)
>  delete mode 100644 arch/arm/common/pl330.c
>  delete mode 100644 arch/arm/include/asm/hardware/pl330.h
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod
