From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 19 Sep 2018 19:09:06 +0200
Subject: [PATCH] ARM: dts: atmel: Fix I2C and SPI bus warnings
In-Reply-To: <20180913181245.25484-4-robh@kernel.org>
References: <20180913181245.25484-4-robh@kernel.org>
Message-ID: <20180919170906.GD2479@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/2018 13:12:28-0500, Rob Herring wrote:
> dtc has new checks for I2C and SPI buses. Fix the warnings in node names
> and unit-addresses.
> 
> arch/arm/boot/dts/at91-dvk_som60.dtb: Warning (i2c_bus_reg): /ahb/apb/i2c at f0018000/eeprom at 87: I2C bus unit address format error, expected "57"
> arch/arm/boot/dts/at91-dvk_som60.dtb: Warning (i2c_bus_reg): /ahb/apb/i2c at f0018000/ft5426 at 56: I2C bus unit address format error, expected "38"
> arch/arm/boot/dts/at91-vinco.dtb: Warning (i2c_bus_reg): /ahb/apb/i2c at f8024000/rtc at 64: I2C bus unit address format error, expected "32"
> arch/arm/boot/dts/at91sam9260ek.dtb: Warning (spi_bus_reg): /ahb/apb/spi at fffc8000/mtd_dataflash at 0: SPI bus unit address format error, expected "1"
> arch/arm/boot/dts/at91sam9g20ek_2mmc.dtb: Warning (spi_bus_reg): /ahb/apb/spi at fffc8000/mtd_dataflash at 0: SPI bus unit address format error, expected "1"
> arch/arm/boot/dts/at91sam9g20ek.dtb: Warning (spi_bus_reg): /ahb/apb/spi at fffc8000/mtd_dataflash at 0: SPI bus unit address format error, expected "1"
> arch/arm/boot/dts/at91sam9261ek.dtb: Warning (spi_bus_reg): /ahb/apb/spi at fffc8000/tsc2046 at 0: SPI bus unit address format error, expected "2"
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.
> 
>  arch/arm/boot/dts/at91-dvk_su60_somc.dtsi     | 4 ++--
>  arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi | 4 ++--
>  arch/arm/boot/dts/at91-vinco.dts              | 2 +-
>  arch/arm/boot/dts/at91sam9260ek.dts           | 2 +-
>  arch/arm/boot/dts/at91sam9261ek.dts           | 2 +-
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi   | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
