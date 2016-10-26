From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Oct 2016 21:53:38 +0800
Subject: [PATCH 4/7] ARM: dts: add I2SE Duckbill common definitions
In-Reply-To: <1477164150-13553-5-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
 <1477164150-13553-5-git-send-email-mhei@heimpold.de>
Message-ID: <20161026135338.GP30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 09:22:27PM +0200, Michael Heimpold wrote:
> +			pinctrl at 80018000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&hog_pins_a>;
> +
> +				mac0_phy_reset_pin: mac0_phy_reset_pin at 0 {

Please use hyphen instead of underscore in node name.

Shawn

> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
> +					>;
> +					fsl,drive-strength = <MXS_DRIVE_4mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_DISABLE>;
> +				};
