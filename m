From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Sep 2018 16:59:50 +0800
Subject: [PATCH] ARM: dts: sunxi: Fix I2C bus warnings
In-Reply-To: <20180913181245.25484-8-robh@kernel.org>
References: <20180913181245.25484-8-robh@kernel.org>
Message-ID: <CAGb2v66dq2N5GAR6-NOEEV5i18UCdyzUpojetxGUzx9+yZjiZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 2:12 AM Rob Herring <robh@kernel.org> wrote:
>
> dtc has new checks for I2C buses. Fix the warnings in unit-addresses.
>
> arch/arm/boot/dts/sun8i-a23-gt90h-v4.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
> arch/arm/boot/dts/sun8i-a23-inet86dz.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
> arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
> arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
> arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: I2C bus unit address format error, expected "40"
> arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: missing or empty reg property
> arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: missing or empty reg property
> arch/arm/boot/dts/sun8i-a33-q8-tablet.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2ac00/touchscreen at 0: missing or empty reg property
> arch/arm/boot/dts/sun5i-a13-utoo-p66.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: I2C bus unit address format error, expected "40"
> arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
> arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
> arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
> arch/arm/boot/dts/sun5i-a13-q8-tablet.dtb: Warning (i2c_bus_reg): /soc at 1c00000/i2c at 1c2b000/touchscreen: missing or empty reg property
>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but
> will for 4.20.

Applied for 4.20. Thanks!
