From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 10 Dec 2014 22:27:42 +0800
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1418221662.21309.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wed, 2014-12-10 at 18:50 +0800, Eddie Huang wrote:
<...>
> diff --git a/arch/arm64/boot/dts/mt8173-evb.dts b/arch/arm64/boot/dts/mt8173-evb.dts
> new file mode 100644
> index 0000000..adf26dd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mt8173-evb.dts
<...>
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <1 13 0x8>,
> +			     <1 14 0x8>,
> +			     <1 11 0x8>,
> +			     <1 10 0x8>;
> +		clock-frequency = <13000000>;

I believe our firmware doesn't need this line. Please remove it.

Joe.C
