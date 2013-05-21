From: neidhard.kim@lge.com (Jongsung Kim)
Date: Tue, 21 May 2013 15:07:34 +0900
Subject: [PATCH] ARM: bcm2835: override the HW UART periphid
In-Reply-To: <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
References: <519AD82A.6090809@wwwdotorg.org>
 <1369116149-2361-1-git-send-email-neidhard.kim@lge.com>
Message-ID: <008d01ce55e9$7c479510$74d6bf30$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jongsung Kim <neidhard.kim@lge.com> :
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi
b/arch/arm/boot/dts/bcm2835.dtsi
> index f0052dc..1e12aef 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -44,6 +44,7 @@
>  			reg = <0x7e201000 0x1000>;
>  			interrupts = <2 25>;
>  			clock-frequency = <3000000>;
> +			arm,primecell-periphid = <0x00241011>;
>  		};
>  
>  		gpio: gpio {

Stephen, how do you think about this kind of approach instead?
