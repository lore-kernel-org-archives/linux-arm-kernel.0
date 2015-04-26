From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 26 Apr 2015 14:12:04 +0300
Subject: [PATCH v1 2/2] ARM: dts: rockchip: set dr_mode property for
 rk3288-firefly board
In-Reply-To: <1430041299-24874-2-git-send-email-lyz@rock-chips.com>
References: <1430041299-24874-1-git-send-email-lyz@rock-chips.com>
 <1430041299-24874-2-git-send-email-lyz@rock-chips.com>
Message-ID: <553CC804.4050206@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 4/26/2015 12:41 PM, Yunzhi Li wrote:

> rk3288-firefly board use the dwc2 usb otg controller as a host
> controller and the device mode not used, so the dr_mode should be
> "host" then the dwc2 usb otg controller will work at host only
> mode

> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>

> ---

>   arch/arm/boot/dts/rk3288-firefly.dtsi | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
> index e6f873a..a861776 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -466,6 +466,7 @@
>   };
>
>   &usb_otg {
> +	dr_modr = "host";

    You meant to type "dr_mode".

WBR, Sergei
