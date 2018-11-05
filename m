From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Nov 2018 16:06:18 -0600
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add Gru Scarlet devicetrees
In-Reply-To: <20181101123639.15560-2-heiko@sntech.de>
References: <20181101123639.15560-1-heiko@sntech.de>
 <20181101123639.15560-2-heiko@sntech.de>
Message-ID: <20181105220618.GA20928@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  1 Nov 2018 13:36:39 +0100, Heiko Stuebner wrote:
> Gru-Scarlet is a tablet device using ChomeOS, dual-dsi display
> and Wacom touchscreen with stylus.
> 
> There exist two variants in the market using different displays
> that are differentiated via their sku-id.
> The bootloader on them also determines the correct devicetree to
> load via the sku-id.
> 
> So add a common scarlet dtsi and two minimal board devicetrees
> for the two display variants.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes in v2:
> - drop coreboot param override
> - rebase against current master state so it will apply against 4.20-rc1
> 
>  .../devicetree/bindings/arm/rockchip.txt      |  34 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>  .../dts/rockchip/rk3399-gru-scarlet-inx.dts   |  33 +
>  .../dts/rockchip/rk3399-gru-scarlet-kd.dts    |  33 +
>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 594 ++++++++++++++++++
>  5 files changed, 696 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> 

Reviewed-by: Rob Herring <robh@kernel.org>
