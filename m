From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Feb 2013 10:46:11 -0800
Subject: [PATCH] RX-51: Add leds lp5523 names from Maemo 5 2.6.28 kernel
In-Reply-To: <1358650244-29722-1-git-send-email-pali.rohar@gmail.com>
References: <1358650244-29722-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20130201184610.GO22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [130119 18:54]:
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

Thanks applying into omap-for-v3.9/board with the subject
also pasted to the description.

Tony
 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 7611958..9a0dbb7 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -168,30 +168,39 @@ static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
>  #if defined(CONFIG_LEDS_LP5523) || defined(CONFIG_LEDS_LP5523_MODULE)
>  static struct lp5523_led_config rx51_lp5523_led_config[] = {
>  	{
> +		.name		= "lp5523:kb1",
>  		.chan_nr	= 0,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:kb2",
>  		.chan_nr	= 1,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:kb3",
>  		.chan_nr	= 2,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:kb4",
>  		.chan_nr	= 3,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:b",
>  		.chan_nr	= 4,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:g",
>  		.chan_nr	= 5,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:r",
>  		.chan_nr	= 6,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:kb5",
>  		.chan_nr	= 7,
>  		.led_current	= 50,
>  	}, {
> +		.name		= "lp5523:kb6",
>  		.chan_nr	= 8,
>  		.led_current	= 50,
>  	}
> -- 
> 1.7.10.4
> 
