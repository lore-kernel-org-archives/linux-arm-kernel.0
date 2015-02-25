From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 25 Feb 2015 15:13:11 +0000
Subject: [PATCH 3/6] ARM: DT: STi: STiH407: Update picophyreset for the
 usb3 controllers usb2 phy
In-Reply-To: <1424871377-1795-4-git-send-email-peter.griffin@linaro.org>
References: <1424871377-1795-1-git-send-email-peter.griffin@linaro.org>
 <1424871377-1795-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150225151310.GF5132@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Feb 2015, Peter Griffin wrote:

> Ths picophyreset is incorrectly defined, which stops the usb2 phy being
> taken out of reset.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index c06a546..186412d 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -280,7 +280,7 @@
>  			#phy-cells = <0>;
>  			st,syscfg = <&syscfg_core 0x100 0xf4>;
>  			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
> -				 <&picophyreset STIH407_PICOPHY0_RESET>;
> +				 <&picophyreset STIH407_PICOPHY2_RESET>;
>  			reset-names = "global", "port";
>  		};
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
