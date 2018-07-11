From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 11 Jul 2018 16:57:13 +0200
Subject: [PATCH] ARM: dts: imx: Add ZII SCU3 ESB
In-Reply-To: <20180711050704.11492-1-andrew.smirnov@gmail.com>
References: <20180711050704.11492-1-andrew.smirnov@gmail.com>
Message-ID: <20180711145713.GB14155@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:07:04PM -0700, Andrey Smirnov wrote:
> +		switch at 0 {
> +			compatible = "marvell,mv88e6085";
> +			reg = <0>;
> +			dsa,member = <0 0>;
> +			eeprom-length = <512>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;

Hi Andrey

I don't see a pinmux for this GPIO. Is one needed?

    Andrew
