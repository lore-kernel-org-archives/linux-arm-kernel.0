From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Nov 2017 17:10:38 +0100
Subject: [PATCH] ARM: dts: Add basic devicetree for D-Link DNS-313
In-Reply-To: <20171129154720.16662-1-linus.walleij@linaro.org>
References: <20171129154720.16662-1-linus.walleij@linaro.org>
Message-ID: <20171129161038.GG24881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	mdio0: ethernet-phy {
> +		compatible = "virtual,mdio-gpio";
> +		/* Uses MDC and MDIO */
> +		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> +			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* This is a Realtek RTL8211B Gigabit ethernet transceiver */
> +		phy0: ethernet-phy at 0 {

Hi Linus

ethernet-phy at 1

	Andrew
