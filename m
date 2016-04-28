From: briannorris@chromium.org (Brian Norris)
Date: Thu, 28 Apr 2016 09:03:53 -0700
Subject: [PATCH v4 2/4] ARM64: dts: rockchip: add core dtsi file for
 RK3399 SoCs
In-Reply-To: <1461743693-10671-3-git-send-email-jay.xu@rock-chips.com>
References: <1461743693-10671-1-git-send-email-jay.xu@rock-chips.com>
 <1461743693-10671-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20160428160353.GA95284@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko, Jianqun,

On Wed, Apr 27, 2016 at 03:54:51PM +0800, Jianqun Xu wrote:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> new file mode 100644
> index 0000000..5a8a915
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -0,0 +1,1022 @@
[...]
> +	sdhci: sdhci at fe330000 {
> +		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";

Not to rain on the parade too much, as this is already applied, but is
the "rockchip,rk3399-sdhci-5.1" string documented anywhere? I don't see
it.

> +		reg = <0x0 0xfe330000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		status = "disabled";
> +	};

[...]

Brian
