From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 16:50:12 +0800
Subject: [PATCH 1/3] ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
In-Reply-To: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
References: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170503085010.GF18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 10:22:02PM +0200, Alexandre Belloni wrote:
> The rv4162 vendor is microcrystal, not ST.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> index bad3c9f9eeac..b63134e3b51a 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
> @@ -408,7 +408,7 @@
>  	};
>  
>  	rtc: rtc at 68 {
> -		compatible = "st,rv4162";
> +		compatible = "microcrystal,rv4162";

The compatible is not documented?

Shawn

>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_rv4162>;
>  		reg = <0x68>;
> -- 
> 2.11.0
> 
