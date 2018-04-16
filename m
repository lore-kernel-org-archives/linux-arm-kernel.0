From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 15:24:26 +0800
Subject: [PATCH v2 2/2] ARM: dts: i.MX6: Add BTicino i.MX6DL Mamoj
 initial support
In-Reply-To: <20180319194114.15349-2-jagan@amarulasolutions.com>
References: <20180319194114.15349-1-jagan@amarulasolutions.com>
 <20180319194114.15349-2-jagan@amarulasolutions.com>
Message-ID: <20180416072425.GC25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 01:11:14AM +0530, Jagan Teki wrote:
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	pmic: pfuze100 at 8 {

pfuze100: pmic at 8

I fixed it up and applied both patches.

Shawn

> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
