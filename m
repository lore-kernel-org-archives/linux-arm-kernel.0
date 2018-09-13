From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 13 Sep 2018 15:06:28 -0700
Subject: [PATCH] arm64: dts: broadcom: Fix I2C and SPI bus warnings
In-Reply-To: <20180913181245.25484-18-robh@kernel.org>
References: <20180913181245.25484-18-robh@kernel.org>
Message-ID: <e86d75f7-d4b8-079b-9b95-b30501665078@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/13/18 11:12, Rob Herring wrote:
> dtc has new checks for I2C and SPI buses. Fix the warnings in node names
> and unit-addresses.
> 
> arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (i2c_bus_reg): /hsls/i2c at e0000/pcf8574 at 20: I2C bus unit address format error, expected "27"
> arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dtb: Warning (i2c_bus_reg): /hsls/i2c at e0000/pcf8574 at 20: I2C bus unit address format error, expected "27"
> arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (spi_bus_bridge): /hsls/ssp at 180000: node name for SPI buses should be 'spi'
> arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dtb: Warning (spi_bus_bridge): /hsls/ssp at 190000: node name for SPI buses should be 'spi'
> 
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to devicetree-arm64/next, thanks Rob!

-- 
Florian
