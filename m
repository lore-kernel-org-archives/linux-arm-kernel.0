From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 26 Jul 2013 12:37:47 +0200
Subject: [PATCH 05/10] ARM: sunxi: Add Allwinner A31 DTSI
In-Reply-To: <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130726123747.7c88d976@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Wed, 24 Jul 2013 00:25:07 +0200, Maxime Ripard wrote:

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..1482533 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -210,7 +210,8 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
>  	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-hackberry.dtb \
>  	sun5i-a10s-olinuxino-micro.dtb \
> -	sun5i-a13-olinuxino.dtb
> +	sun5i-a13-olinuxino.dtb \
> +	sun6i-a31-colombus.dtb

Wrong patch for this chunk. The colombus .dts is added in PATCH 06/10.

> +	soc at 01c20000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x01c20000 0x300000>;
> +		ranges;

Just curious, what are these reg and ranges properties for?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
