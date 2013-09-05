From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Sep 2013 17:05:36 +0100
Subject: [PATCH v5 03/13] arm64: define DMA_ERROR_CODE
In-Reply-To: <1377801154-29215-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
 <1377801154-29215-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130905160536.GH11887@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 07:32:24PM +0100, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: catalin.marinas at arm.com
> CC: will.deacon at arm.com
> ---
>  arch/arm64/include/asm/dma-mapping.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 8d18100..c2cb8a0 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -25,6 +25,7 @@
>  
>  #define ARCH_HAS_DMA_GET_REQUIRED_MASK
>  
> +#define DMA_ERROR_CODE	(~0)

I wonder why this isn't more generic. It looks like most (all?)
architectures define it in the same way.

-- 
Catalin
