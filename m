From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Fri, 27 Feb 2015 08:42:32 +0100
Subject: [PATCH 1/5] ARM: dts: imx28-apf28dev: Add pinctrl for USB OTG
 ID pin
In-Reply-To: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20150227084232.43bad15c@x230.trabucayre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

Gwen

On Fri, 13 Feb 2015 15:12:01 +0100
Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com> wrote:

> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx28-apf28dev.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
> index 1f38a05..86e8d81 100644
> --- a/arch/arm/boot/dts/imx28-apf28dev.dts
> +++ b/arch/arm/boot/dts/imx28-apf28dev.dts
> @@ -143,7 +143,8 @@
>  	ahb at 80080000 {
>  		usb0: usb at 80080000 {
>  			pinctrl-names = "default";
> -			pinctrl-0 = <&usb0_otg_apf28dev>;
> +			pinctrl-0 = <&usb0_otg_apf28dev
> +					&usb0_id_pins_b>;
>  			vbus-supply = <&reg_usb0_vbus>;
>  			status = "okay";
>  		};
> -- 
> 2.0.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
