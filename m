From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Sep 2018 17:00:37 +0800
Subject: [PATCH] ARM: dts: fsl: Fix SPI bus warnings
In-Reply-To: <20180913181245.25484-5-robh@kernel.org>
References: <20180913181245.25484-5-robh@kernel.org>
Message-ID: <20180926090036.GB26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 01:12:29PM -0500, Rob Herring wrote:
> dtc has new checks for SPI buses. Fix the warnings in node names and
> unit-addresses.
> 
> There's over 100 warnings for FSL boards, a few examples:
> 
> arch/arm/boot/dts/imx28-duckbill-2-spi.dtb: Warning (spi_bus_bridge): /apb at 80000000/apbh at 80000000/ssp at 80014000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/imx53-ppd.dtb: Warning (spi_bus_bridge): /soc/aips at 50000000/spba at 50000000/ecspi at 50010000: node name for SPI buses should be 'spi'
> arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb: Warning (spi_bus_reg): /soc/aips-bus at 2000000/spba-bus at 2000000/spi at 2014000/mcp251x at 1: SPI bus unit address format error, expected "0"
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks.
