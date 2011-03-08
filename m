From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Mar 2011 20:44:08 +0100
Subject: [PATCH 1/4] spi_imx: Fix misspelled configuration variable
	SOC_IMX31
In-Reply-To: <1299425955.2624.30.camel@realization>
References: <1299425878.2624.29.camel@realization>
	<1299425955.2624.30.camel@realization>
Message-ID: <20110308194408.GA22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2011 at 04:39:15PM +0100, Alberto Panizzo wrote:
> Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
>  drivers/spi/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index bd9dad5..996cf03 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -161,7 +161,7 @@ config SPI_IMX_VER_0_0
>  	def_bool y if SOC_IMX21 || SOC_IMX27
>  
>  config SPI_IMX_VER_0_4
> -	def_bool y if SOC_MX31
> +	def_bool y if SOC_IMX31
>  
>  config SPI_IMX_VER_0_7
>  	def_bool y if ARCH_MX25 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
