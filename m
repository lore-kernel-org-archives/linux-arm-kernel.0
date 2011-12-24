From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 10:41:38 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: dma-ops.h needs mach/dma.h
In-Reply-To: <1324657414-27991-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1324657414-27991-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1324657414-27991-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <088801ccc1dd$2df5d300$89e17900$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> dma-ops.h uses samsung_dma_is_dmadev so it needs to have mach/dma.h
> included.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-samsung/include/plat/dma-ops.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-
> samsung/include/plat/dma-ops.h
> index 70b6325..71a6827 100644
> --- a/arch/arm/plat-samsung/include/plat/dma-ops.h
> +++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
> @@ -14,6 +14,7 @@
>  #define __SAMSUNG_DMA_OPS_H_ __FILE__
> 
>  #include <linux/dmaengine.h>
> +#include <mach/dma.h>
> 
>  struct samsung_dma_prep_info {
>  	enum dma_transaction_type cap;
> --
> 1.7.7.3

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
