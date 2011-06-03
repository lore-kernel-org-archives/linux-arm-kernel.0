From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Fri, 3 Jun 2011 12:59:06 +0200
Subject: [PATCH v2 3/4] ARM: mxc: migrate mach-imx gpio driver to gpio-mxc
In-Reply-To: <1306985632-18820-4-git-send-email-shawn.guo@linaro.org>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
	<1306985632-18820-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201106031259.06088.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi, 2 juin 2011 05.33:51, Shawn Guo a ?crit :

> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c
>  b/arch/arm/mach-imx/mach-mx31moboard.c index eaa51e4..a52fd36 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -507,6 +507,8 @@ core_param(mx31moboard_baseboard,
>  mx31moboard_baseboard, int, 0444); */
>  static void __init mx31moboard_init(void)
>  {
> +	imx31_soc_init();
> +
>  	mxc_iomux_setup_multiple_pins(moboard_pins, ARRAY_SIZE(moboard_pins),
>  		"moboard");
> 

Acked-by: Philippe Retornaz <philippe.retornaz@epfl.ch>

Thanks,

Philippe
