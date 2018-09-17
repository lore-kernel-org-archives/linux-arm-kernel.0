From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 17 Sep 2018 10:21:46 +0200
Subject: [PATCH] arm64: dts: rockchip: Fix I2C bus unit-address error
In-Reply-To: <20180913181245.25484-21-robh@kernel.org>
References: <20180913181245.25484-21-robh@kernel.org>
Message-ID: <2920025.RxADjLU2lV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. September 2018, 20:12:45 CEST schrieb Rob Herring:
> dtc has new checks for I2C buses. Fix the warnings in unit-addresses.
> 
> arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: Warning (i2c_bus_reg): /i2c at ff3d0000/codec at 0a: I2C bus unit address format error, expected "a"
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.

applied for 4.20

Thanks
Heiko
