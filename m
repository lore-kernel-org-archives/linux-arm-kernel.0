From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Sep 2018 17:09:18 +0800
Subject: [PATCH] arm64: dts: fsl: Fix I2C and SPI bus warnings
In-Reply-To: <20180913181245.25484-19-robh@kernel.org>
References: <20180913181245.25484-19-robh@kernel.org>
Message-ID: <20180926090916.GC26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 01:12:43PM -0500, Rob Herring wrote:
> dtc has new checks for I2C and SPI buses. Fix the SPI bus node names
> and warnings in unit-addresses.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: Warning (i2c_bus_reg): /soc/i2c at 2180000/eeprom at 57: I2C bus unit address format error, expected "53"
> arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: Warning (i2c_bus_reg): /soc/i2c at 2180000/eeprom at 56: I2C bus unit address format error, expected "52"
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks.
