From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 13 Sep 2018 22:17:39 +0200
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
In-Reply-To: <20180913195751.1833227-1-vijaykhemka@fb.com>
References: <20180913195751.1833227-1-vijaykhemka@fb.com>
Message-ID: <20180913201739.GG23892@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/arch/arm/boot/dts/Makefile
> @@ -1206,4 +1206,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-opp-witherspoon.dtb \
>  	aspeed-bmc-opp-zaius.dtb \
>  	aspeed-bmc-portwell-neptune.dtb \
> +	aspeed-bmc-facebook-tiogapass.dtb \

Hi Vijay

These entries are normally kept in alphabetic order.

> +	leds {
> +		compatible = "gpio-leds";
> +		postcode0 {
> +			label="BMC_UP";

Documentation/leds/leds-class.txt

LED Device Naming
=================

Is currently of the form:

"devicename:colour:function"

	Andrew
