From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 11:30:02 +0200
Subject: [PATCH] ARM: imx/eukrea_mbimx27-baseboard: fix typo in error
 message
In-Reply-To: <1335506107-15476-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1335506107-15476-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120427093002.GB20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 07:55:07AM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks

Sascha

> ---
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> index 5f2f91d..b46cab0 100644
> --- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> +++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
> @@ -243,7 +243,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
>  static void __maybe_unused ads7846_dev_init(void)
>  {
>  	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
> -		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
> +		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
>  		return;
>  	}
>  	gpio_direction_input(ADS7846_PENDOWN);
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
