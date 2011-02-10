From: B20596@freescale.com (Li Frank-B20596)
Date: Thu, 10 Feb 2011 03:23:00 +0000
Subject: [PATCH 2/2] ARM i.MX23/28: Add framebuffer device support
In-Reply-To: <1297257651-8002-3-git-send-email-s.hauer@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <09EC74FE2C9E8444BF2FF67BD36E1D6916778B@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-
> mx23.c
> index ca72a05..bfc7f27 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -446,7 +446,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
>  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
>  	_REGISTER_CLOCK(NULL, "audio", audio_clk)
> -	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> +	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
>  };
Why remove mx23 pwm clk here?
