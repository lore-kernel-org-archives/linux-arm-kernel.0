From: michael@walle.cc (Michael Walle)
Date: Tue, 16 Oct 2012 19:21:01 +0200
Subject: [PATCH] ARM: kirkwood: fix LEDs names for lsxl boards
In-Reply-To: <1348519742-20126-1-git-send-email-michael@walle.cc>
References: <1348519742-20126-1-git-send-email-michael@walle.cc>
Message-ID: <201210161921.01657.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andrew,

Can you pick this patch?



Am Montag 24 September 2012, 22:49:02 schrieb Michael Walle:
> Don't use the specific board name in a the common device tree include file.
> Instead use the common name 'lsxl'.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> b/arch/arm/boot/dts/kirkwood-lsxl.dtsi index 8ac51c0..a1dd36d 100644
> --- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> @@ -67,28 +67,28 @@
>  		compatible = "gpio-leds";
> 
>  		led at 1 {
> -			label = "lschlv2:blue:func";
> +			label = "lsxl:blue:func";
>  			gpios = <&gpio1 4 1>;
>  		};
> 
>  		led at 2 {
> -			label = "lschlv2:red:alarm";
> +			label = "lsxl:red:alarm";
>  			gpios = <&gpio1 5 1>;
>  		};
> 
>  		led at 3 {
> -			label = "lschlv2:amber:info";
> +			label = "lsxl:amber:info";
>  			gpios = <&gpio1 6 1>;
>  		};
> 
>  		led at 4 {
> -			label = "lschlv2:blue:power";
> +			label = "lsxl:blue:power";
>  			gpios = <&gpio1 7 1>;
>  			linux,default-trigger = "default-on";
>  		};
> 
>  		led at 5 {
> -			label = "lschlv2:red:func";
> +			label = "lsxl:red:func";
>  			gpios = <&gpio1 16 1>;
>  		};
>  	};

-- 
michael
