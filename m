From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 24 Jun 2013 11:48:01 +0000
Subject: [PATCH 3/3] ARM: davinci: da850: adopt to pinctrl-single driver
 to configure multiple pins
In-Reply-To: <1369145282-14419-5-git-send-email-prakash.pm@ti.com>
References: <1369145282-14419-1-git-send-email-prakash.pm@ti.com>
 <1369145282-14419-5-git-send-email-prakash.pm@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA911E0@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Tue, May 21, 2013 at 19:38:02, Manjunathappa, Prakash wrote:
> function-mask property is a mask for a pin at each pin configure offset
> in a pincontrol register.
> 

Got 1/3 and 2/3 accepted, I do not know if this gets merged via DaVinci tree or
pincontrol tree. Could you please takecare of this?

Thanks,
Prakash

> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  arch/arm/boot/dts/da850.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 4d43046..9bec36c 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -37,7 +37,7 @@
>  			#size-cells = <0>;
>  			pinctrl-single,bit-per-mux;
>  			pinctrl-single,register-width = <32>;
> -			pinctrl-single,function-mask = <0xffffffff>;
> +			pinctrl-single,function-mask = <0xf>;
>  			status = "disabled";
>  
>  			nand_cs3_pins: pinmux_nand_pins {
> -- 
> 1.7.4.1
> 
> 
