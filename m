From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 29 Nov 2017 21:34:03 +0100
Subject: [PATCH v2 2/6] ARM: ep93xx: ts72xx: Provide include guards for
 ts72xx.h file
In-Reply-To: <20171121143204.1839-3-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de> <20171121143204.1839-3-lukma@denx.de>
Message-ID: <ccfbd627-b71b-4417-3c84-e2a04141c64f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 21/11/17 15:32, Lukasz Majewski wrote:
> This commit adds include file guards to ts72xx.h
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> Changes for v2:
> - None
> ---
>  arch/arm/mach-ep93xx/ts72xx.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
> index b89850f1a965..d9ff04db3221 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.h
> +++ b/arch/arm/mach-ep93xx/ts72xx.h
> @@ -12,6 +12,9 @@
>   * febfd000	22800000	4K	options register #2
>   */
>  
> +#ifndef __TS72XX_H_
> +#define __TS72XX_H_
> +
>  #define TS72XX_MODEL_PHYS_BASE		0x22000000
>  #define TS72XX_MODEL_VIRT_BASE		IOMEM(0xfebff000)
>  #define TS72XX_MODEL_SIZE		0x00001000
> @@ -86,3 +89,4 @@ static inline int is_ts9420_installed(void)
>  					TS72XX_OPTIONS2_TS9420);
>  }
>  #endif
> +#endif /* __TS72XX_H_ */
