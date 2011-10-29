From: jkosina@suse.cz (Jiri Kosina)
Date: Sat, 29 Oct 2011 21:28:05 +0200 (CEST)
Subject: [PATCH] [TRIVIAL] ARM: pxa: Fix typo
	'CONFIG_BACKLIGHT_PWM__MODULE'
In-Reply-To: <1318347115.5754.3.camel@x61.thuisdomein>
References: <1318347115.5754.3.camel@x61.thuisdomein>
Message-ID: <alpine.LNX.2.00.1110292127320.3541@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Oct 2011, Paul Bolle wrote:

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested (I don't think I've got the hardware, nor have I got the
> toolchain at hand, etc.).
> 
>  arch/arm/mach-pxa/colibri-pxa270-income.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
> index 80538b8..248804b 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270-income.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
> @@ -183,7 +183,7 @@ static inline void income_lcd_init(void) {}
>  /******************************************************************************
>   * Backlight
>   ******************************************************************************/
> -#if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM__MODULE)
> +#if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
>  static struct platform_pwm_backlight_data income_backlight_data = {
>  	.pwm_id		= 0,
>  	.max_brightness	= 0x3ff,

I'd like to have this at least compile-tested, adding some CCs.

-- 
Jiri Kosina
SUSE Labs
