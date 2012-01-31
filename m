From: stigge@antcom.de (Roland Stigge)
Date: Tue, 31 Jan 2012 17:30:15 +0100
Subject: [PATCH] arm: lpc32xx: phy3250: add rtc & touch device
In-Reply-To: <1328026425-8177-1-git-send-email-w.sang@pengutronix.de>
References: <1328026425-8177-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <4F281717.6010305@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2012 05:13 PM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Kevin Wells <kevin.wells@nxp.com>
> ---
> 
> Tested after applying Roland's series, but should be appliable even
> without it.
> 
>  arch/arm/mach-lpc32xx/phy3250.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index b429d18..905d0c9 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -298,6 +298,8 @@ static struct platform_device lpc32xx_net_device = {
>  };
>  
>  static struct platform_device *phy3250_devs[] __initdata = {
> +	&lpc32xx_rtc_device,
> +	&lpc32xx_tsc_device,
>  	&lpc32xx_i2c0_device,
>  	&lpc32xx_i2c1_device,
>  	&lpc32xx_i2c2_device,

Signed-off-by: Roland Stigge <stigge@antcom.de>
