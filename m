From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Feb 2018 17:11:08 +0100
Subject: [PATCH] ARM: dts: armada: netgear-rn*: fix rtc node name
In-Reply-To: <20180210064130.6422-1-alexandre.belloni@bootlin.com> (Alexandre
 Belloni's message of "Sat, 10 Feb 2018 07:41:30 +0100")
References: <20180210064130.6422-1-alexandre.belloni@bootlin.com>
Message-ID: <87h8qkq38j.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,
 
 On sam., f?vr. 10 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> The node name should be generic and must not contain the part number.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 2 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index b1a96e95e921..d2225bd4a76f 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -103,7 +103,7 @@
>  
>  				status = "okay";
>  
> -				isl12057: isl12057 at 68 {
> +				isl12057: rtc at 68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
>  					wakeup-source;
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> index d67e7aa42b54..b73cae836bc1 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -105,7 +105,7 @@
>  
>  				status = "okay";
>  
> -				isl12057: isl12057 at 68 {
> +				isl12057: rtc at 68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
>  					wakeup-source;
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> index 40c6fe21e720..e66fe80cf279 100644
> --- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -115,7 +115,7 @@
>  					reg = <0x4c>;
>  				};
>  
> -				isl12057: isl12057 at 68 {
> +				isl12057: rtc at 68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
>  					wakeup-source;
> -- 
> 2.16.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
