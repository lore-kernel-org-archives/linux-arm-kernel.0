From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Jul 2015 17:02:18 +0200
Subject: [PATCH v2 2/3] ARM: at91/dt: add basic dtsi for sama5d2 SoC
In-Reply-To: <1438079151-29653-3-git-send-email-nicolas.ferre@atmel.com>
References: <1438079151-29653-1-git-send-email-nicolas.ferre@atmel.com>
 <1438079151-29653-3-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150729150218.GA6073@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/07/2015 at 12:25:50 +0200, Nicolas Ferre wrote :
> +
> +		sdmmc0: sdio-host at a0000000 {
> +			compatible = "atmel,sama5d2-sdhci";
> +			reg = <0xa0000000 0x300>;
> +			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
> +			clock-names = "hclock", "multclk", "baseclk";

Those bindings have not been taken yet. Are you confident enough this
will go in as-is?

> +			status = "disabled";
> +		};
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
