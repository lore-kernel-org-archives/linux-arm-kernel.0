From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 24 Jun 2013 18:44:30 +0800
Subject: [PATCH 2/3] ARM: at91/PMC: at91sam9n12 family have a PLLB
In-Reply-To: <1a09cb9b88027ff0f5226d977786275f0463b930.1372064763.git.nicolas.ferre@atmel.com>
References: <cover.1372064763.git.nicolas.ferre@atmel.com>
 <1a09cb9b88027ff0f5226d977786275f0463b930.1372064763.git.nicolas.ferre@atmel.com>
Message-ID: <51C8230E.20804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 05:08 PM, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   arch/arm/mach-at91/clock.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> index 085a79d..978de42 100644
> --- a/arch/arm/mach-at91/clock.c
> +++ b/arch/arm/mach-at91/clock.c
> @@ -75,7 +75,6 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
>   #define cpu_has_pllb()		(!(cpu_is_at91sam9rl() \
>   				|| cpu_is_at91sam9g45() \
>   				|| cpu_is_at91sam9x5() \
> -				|| cpu_is_at91sam9n12() \
>   				|| cpu_is_sama5d3()))
>
>   #define cpu_has_upll()		(cpu_is_at91sam9g45() \
>
