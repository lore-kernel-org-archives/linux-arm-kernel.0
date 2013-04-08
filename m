From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 8 Apr 2013 17:44:58 +0200
Subject: [PATCH] ARM: at91: remove unused dbgu_readl() macro
In-Reply-To: <1364981103-22980-1-git-send-email-nicolas.ferre@atmel.com>
References: <1364981103-22980-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5162E5FA.8080807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 11:25 AM, Nicolas Ferre :
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I stack this up on at91-3.10-cleanup right now.

> ---
>  arch/arm/mach-at91/include/mach/at91_dbgu.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_dbgu.h b/arch/arm/mach-at91/include/mach/at91_dbgu.h
> index 2aa0c5e..3b59485 100644
> --- a/arch/arm/mach-at91/include/mach/at91_dbgu.h
> +++ b/arch/arm/mach-at91/include/mach/at91_dbgu.h
> @@ -16,9 +16,6 @@
>  #ifndef AT91_DBGU_H
>  #define AT91_DBGU_H
>  
> -#define dbgu_readl(dbgu, field) \
> -	__raw_readl(AT91_VA_BASE_SYS + dbgu + AT91_DBGU_ ## field)
> -
>  #if !defined(CONFIG_ARCH_AT91X40)
>  #define AT91_DBGU_CR		(0x00)	/* Control Register */
>  #define AT91_DBGU_MR		(0x04)	/* Mode Register */
> 


-- 
Nicolas Ferre
