From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 24 Jun 2013 18:46:01 +0800
Subject: [PATCH 3/3] ARM: at91/PMC: at91sam9n12 family has USB HS feature
In-Reply-To: <a3b28f9041482ff60ed0b1b7a6f11d0b1beb5163.1372064763.git.nicolas.ferre@atmel.com>
References: <cover.1372064763.git.nicolas.ferre@atmel.com>
 <a3b28f9041482ff60ed0b1b7a6f11d0b1beb5163.1372064763.git.nicolas.ferre@atmel.com>
Message-ID: <51C82369.1080900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 06/24/2013 05:08 PM, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/mach-at91/clock.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> index 978de42..1b9bbba 100644
> --- a/arch/arm/mach-at91/clock.c
> +++ b/arch/arm/mach-at91/clock.c
> @@ -88,6 +88,7 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
>   #define cpu_has_udpfs()		(!(cpu_is_at91sam9rl() \
>   				|| cpu_is_at91sam9g45() \
>   				|| cpu_is_at91sam9x5() \
> +				|| cpu_is_at91sam9n12() \
>   				|| cpu_is_sama5d3()))

The at91sam9n12 don't have USB HS device port feature. It only has USB 
FS device port feature.

>   #define cpu_has_plladiv2()	(cpu_is_at91sam9g45() \
>

Best Regards,
Bo Shen
