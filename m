From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 4 Nov 2013 12:09:04 -0400
Subject: [PATCH] thermal: imx_thermal: add module device table
In-Reply-To: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
References: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Message-ID: <5277C6A0.80402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-10-2013 19:56, Russell King wrote:
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
> index 1d6c801c1eb9..ab31552f0360 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -539,3 +539,4 @@ MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>  MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:imx-thermal");
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131104/f6b14c19/attachment.sig>
