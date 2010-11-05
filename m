From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Nov 2010 11:38:31 +0100
Subject: [PATCH 3/3] ARM i.MX spi: fix compilation for i.MX21
In-Reply-To: <1288949165-13286-4-git-send-email-s.hauer@pengutronix.de>
References: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
	<1288949165-13286-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20101105103831.GJ16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 10:26:05AM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe
> ---
>  arch/arm/plat-mxc/devices/platform-spi_imx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
> index e48340e..17f724c 100644
> --- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
> +++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
> @@ -27,6 +27,7 @@ const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
>  	imx_spi_imx_data_entry(MX21, CSPI, "imx21-cspi", _id, _hwid, SZ_4K)
>  	imx21_cspi_data_entry(0, 1),
>  	imx21_cspi_data_entry(1, 2),
> +};
>  #endif
>  
>  #ifdef CONFIG_ARCH_MX25
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
