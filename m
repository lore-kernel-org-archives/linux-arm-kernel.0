From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 22 Oct 2013 16:25:47 +0200
Subject: [PATCH] ARM: dts: am33xx, change usb ctrl module label
In-Reply-To: <1381754961-3252-1-git-send-email-mpa@pengutronix.de>
References: <1381754961-3252-1-git-send-email-mpa@pengutronix.de>
Message-ID: <52668AEB.8000201@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On 14/10/2013 14:49, Markus Pargmann wrote:
> Control module is not usb specific. This patch changes the label to
> usb_ctrl_mod.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

I've just applied it.

Thanks,
Benoit

> ---
>   arch/arm/boot/dts/am33xx.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f9c5da9..14510ee 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -346,7 +346,7 @@
>   			ti,hwmods = "usb_otg_hs";
>   			status = "disabled";
>
> -			ctrl_mod: control at 44e10000 {
> +			usb_ctrl_mod: control at 44e10000 {
>   				compatible = "ti,am335x-usb-ctrl-module";
>   				reg = <0x44e10620 0x10
>   					0x44e10648 0x4>;
> @@ -359,7 +359,7 @@
>   				reg = <0x47401300 0x100>;
>   				reg-names = "phy";
>   				status = "disabled";
> -				ti,ctrl_mod = <&ctrl_mod>;
> +				ti,ctrl_mod = <&usb_ctrl_mod>;
>   			};
>
>   			usb0: usb at 47401000 {
> @@ -407,7 +407,7 @@
>   				reg = <0x47401b00 0x100>;
>   				reg-names = "phy";
>   				status = "disabled";
> -				ti,ctrl_mod = <&ctrl_mod>;
> +				ti,ctrl_mod = <&usb_ctrl_mod>;
>   			};
>
>   			usb1: usb at 47401800 {
>


-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
