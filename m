From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 14:33:17 +0200
Subject: [PATCH] arm64: Drop CONFIG_RTC_LIB dependency
In-Reply-To: <1461776128-7808-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1461776128-7808-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <3380553.F3IlHkp49n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 13:55:28 Ezequiel Garcia wrote:
> The rtc-lib dependency is not required, and seems it was just
> copy-pasted from ARM's Kconfig. If platform requires rtc-lib,
> they should select it individually.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---

Reviewed-by: 

>  arch/arm64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c8762f4613f0..b9d0a81d391c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -99,7 +99,6 @@ config ARM64
>  	select PERF_USE_VMALLOC
>  	select POWER_RESET
>  	select POWER_SUPPLY
> -	select RTC_LIB
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	help
> 
