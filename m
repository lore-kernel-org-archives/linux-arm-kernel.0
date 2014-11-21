From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 21:28:53 +0100
Subject: [PATCHv5 08/10] arm: mvebu: define and use common Armada XP SPI
 pinctrl setting
In-Reply-To: <45747a6875f158a8783206953949834e31822cb7.1416598537.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
 <45747a6875f158a8783206953949834e31822cb7.1416598537.git.arno@natisbad.org>
Message-ID: <20141121202853.GG20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 7cefb9b6d27c..586085a172a7 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -53,6 +53,11 @@
>  				reg = <0x11100 0x100>;
>  			};
>  
> +			spi0: spi at 10600 {
> +				pinctrl-0 = <&spi0_pins>;
> +				pinctrl-names = "default";
> +			};
> +
>  			uart2: serial at 12200 {
>  				compatible = "snps,dw-apb-uart";
>  				pinctrl-0 = <&uart2_pins>;

Guess what ....

      Andrew
