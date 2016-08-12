From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 12 Aug 2016 10:15:27 +0200
Subject: [PATCH RESEND v2 1/3] dt: bindings: add bindings for Allwinner
 A64 usb phy
In-Reply-To: <20160812030622.4492-1-icenowy@aosc.xyz>
References: <20160812030622.4492-1-icenowy@aosc.xyz>
Message-ID: <03c1154e-5d40-f0d9-0990-8b3aa8f47ba0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12-08-16 05:06, Icenowy Zheng wrote:
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Series is still:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


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
