From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 18 Dec 2013 10:47:35 -0400
Subject: [PATCH] thermal: imx_thermal: add module device table
In-Reply-To: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
References: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
Message-ID: <52B1B587.3050106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-12-2013 17:50, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

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
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/4132a3d0/attachment.sig>
