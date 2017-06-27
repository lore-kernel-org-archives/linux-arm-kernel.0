From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 27 Jun 2017 08:53:14 +0200
Subject: [PATCH linux-next v4 0/4] i.MX ECSPI controller slave mode support
In-Reply-To: <20170608051603.16070-1-jiada_wang@mentor.com>
References: <20170608051603.16070-1-jiada_wang@mentor.com>
Message-ID: <20170627065314.jo63yzikv3cbvi2j@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 02:15:59PM +0900, Jiada Wang wrote:
> Changes in v4:
> * rebased to head of linux-next to resolve conflict
> * optimized mx53_ecspi_rx_slave()
> 
> Changes in v3:
> * renamed several variables for for better readability
> * created spi_imx_pio_transfer_slave() for slave pio transfer
> * added fifo_size, has_dmamode and has_slavemode in spi_imx_devtype_data
> 
> Changes in v2:
> * re-workd i.MX ECSPI controller slave mode support based on Geert's work
> 
> Jiada Wang (4):
>   spi: imx: introduce fifo_size and has_dmamode in spi_imx_devtype_data
>   spi: imx: add selection for iMX53 and iMX6 controller
>   ARM: dts: imx: change compatibility for SPI controllers on imx53 later
>     soc
>   spi: imx: Add support for SPI Slave mode

For the series:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
