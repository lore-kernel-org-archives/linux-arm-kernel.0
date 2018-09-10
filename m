From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 10 Sep 2018 14:36:48 +0200
Subject: [PATCH 1/3] dt-bindings: usb: dwc2: add description for px30
In-Reply-To: <20180802130133.4898-2-heiko@sntech.de>
References: <20180802130133.4898-1-heiko@sntech.de>
 <20180802130133.4898-2-heiko@sntech.de>
Message-ID: <10844921.P8CMEBK8dG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, Felipe,

Am Donnerstag, 2. August 2018, 15:01:31 CEST schrieb Heiko Stuebner:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds the compatible of dwc2 for PX30 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Do you want to pick that patch through one of the usb trees, or should
I just apply it with the arm64 devicetree-patches?


Thanks
Heiko


> unchanged from it being part of the general px30 series
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 46da5f184460..6dc3c4a34483 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -6,6 +6,7 @@ Required properties:
>    - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
>    - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
>    - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
> +  - "rockchip,px30-usb", "rockchip,rk3066-usb", "snps,dwc2": for px30 Soc;
>    - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
>    - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
>    - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
> 
