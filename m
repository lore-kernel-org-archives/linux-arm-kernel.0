From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 17 Nov 2009 11:54:30 -0500
Subject: [PATCH] ep93xx: add missing file headers
In-Reply-To: <200911171238.20181.h.feurstein@gmail.com>
References: <200911171238.20181.h.feurstein@gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5526@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2009 4:38 AM, Hubert Feurstein wrote:
>
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/clkdev.h |    4 ++++
>  arch/arm/mach-ep93xx/include/mach/dma.h    |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/clkdev.h b/arch/arm/mach-ep93xx/include/mach/clkdev.h
> index 04b37a8..50cb991 100644
> --- a/arch/arm/mach-ep93xx/include/mach/clkdev.h
> +++ b/arch/arm/mach-ep93xx/include/mach/clkdev.h
> @@ -1,3 +1,7 @@
> +/*
> + * arch/arm/mach-ep93xx/include/mach/clkdev.h
> + */
> +
>  #ifndef __ASM_MACH_CLKDEV_H
>  #define __ASM_MACH_CLKDEV_H
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/dma.h b/arch/arm/mach-ep93xx/include/mach/dma.h
> index ef6bd9d..3a5961d 100644
> --- a/arch/arm/mach-ep93xx/include/mach/dma.h
> +++ b/arch/arm/mach-ep93xx/include/mach/dma.h
> @@ -1,3 +1,7 @@
> +/*
> + * arch/arm/mach-ep93xx/include/mach/dma.h
> + */
> +
>  #ifndef __ASM_ARCH_DMA_H
>  #define __ASM_ARCH_DMA_H

Not _really_ necessary, and can get out of date if the files move.  But
for consistency with the other headers in mach-ep93xx...

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Russell can make the final decision to merge this once it is in his
patch tracker.

Regards,
Hartley
