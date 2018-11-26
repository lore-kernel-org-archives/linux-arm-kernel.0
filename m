From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 09:57:13 +0100
Subject: [PATCH 11/13] ARM: dts: rv1108: Add internal timer support
In-Reply-To: <20181125211907.9895-11-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-11-otavio@ossystems.com.br>
Message-ID: <1767362.WRXMBNmjv7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Sonntag, 25. November 2018, 22:19:05 CET schrieb Otavio Salvador:
> Add support for the internal timer peripheral on RV1108.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  arch/arm/boot/dts/rv1108.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index 7ef6d965871c..42566adadc83 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -291,6 +291,14 @@
>  		};
>  	};
>  
> +	timer: timer at 10350000 {
> +		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";

please also document that new compatible string in
Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt


Heiko
