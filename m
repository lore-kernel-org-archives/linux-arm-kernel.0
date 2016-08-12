From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Aug 2016 15:09:20 +0530
Subject: [PATCH RESEND v2 1/3] dt: bindings: add bindings for Allwinner
 A64 usb phy
In-Reply-To: <20160812030622.4492-1-icenowy@aosc.xyz>
References: <20160812030622.4492-1-icenowy@aosc.xyz>
Message-ID: <57AD9948.6060202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 12 August 2016 08:36 AM, Icenowy Zheng wrote:
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Added "Update sun4i usb phy dt binding documentation to include support for
Allwinner A64 usb phy." and then merged this.

Thanks
Kishon

> ---
>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> index 95736d7..287150d 100644
> --- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
> @@ -10,6 +10,7 @@ Required properties:
>    * allwinner,sun8i-a23-usb-phy
>    * allwinner,sun8i-a33-usb-phy
>    * allwinner,sun8i-h3-usb-phy
> +  * allwinner,sun50i-a64-usb-phy
>  - reg : a list of offset + length pairs
>  - reg-names :
>    * "phy_ctrl"
> 
