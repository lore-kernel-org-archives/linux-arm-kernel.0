From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 20 Nov 2013 11:16:24 +0100
Subject: [PATCH] ARM: at91: remove redundant dependency
In-Reply-To: <1384932191-8967-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1384932191-8967-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <528C8BF8.4080803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2013 08:23, Michael Opdenacker :
> From: Yanis Moreno <yanis.moreno63@gmail.com>
>
> This removes the "depends on SOC_SAM_V7" statement
> in a Kconfig section that's under an "if SOC_SAM_V7"
> condition (same parameter).
>
> Signed-off-by: Yanis Moreno <yanis.moreno63@gmail.com>
> Reviewed-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks for this fix. Integrated in at91-3.14-cleanup branch.
Best regards.

> ---
>   arch/arm/mach-at91/Kconfig |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 699b71e..d1b3fe5 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -61,7 +61,6 @@ comment "Atmel AT91 Processor"
>   if SOC_SAM_V7
>   config SOC_SAMA5D3
>   	bool "SAMA5D3 family"
> -	depends on SOC_SAM_V7
>   	select SOC_SAMA5
>   	select HAVE_FB_ATMEL
>   	select HAVE_AT91_DBGU1
>


-- 
Nicolas Ferre
