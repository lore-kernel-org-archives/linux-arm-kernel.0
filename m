From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 16:03:30 +0800
Subject: [PATCH] thermal: imx_thermal: add module device table
In-Reply-To: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
References: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Message-ID: <20131031080328.GJ23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 11:56:03PM +0000, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/thermal/imx_thermal.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 1d6c801c1eb9..ab31552f0360 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -539,3 +539,4 @@ MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>  MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:imx-thermal");
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);

Can you move it right below of_imx_thermal_match definition?  Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> -- 
> 1.7.4.4
> 
