From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 10:57:39 +0800
Subject: [PATCH] thermal: imx_thermal: add module device table
In-Reply-To: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
References: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
Message-ID: <20131217025737.GD6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 09:50:04PM +0000, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/thermal/imx_thermal.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 1d6c801c1eb9..230864886775 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -522,6 +522,7 @@ static const struct of_device_id of_imx_thermal_match[] = {
>  	{ .compatible = "fsl,imx6q-tempmon", },
>  	{ /* end */ }
>  };
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  
>  static struct platform_driver imx_thermal = {
>  	.driver = {
> -- 
> 1.7.4.4
> 
