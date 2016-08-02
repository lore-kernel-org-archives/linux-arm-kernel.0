From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 2 Aug 2016 10:45:57 +0200
Subject: [PATCH v2 1/3] dt: bindings: add bindings for Allwinner A64 usb
 phy
In-Reply-To: <20160801163448.54921-1-icenowy@aosc.xyz>
References: <20160801163448.54921-1-icenowy@aosc.xyz>
Message-ID: <82b383c2-b4f8-f7ee-6781-41d9efff11af@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Series looks good to me and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


On 01-08-16 18:34, Icenowy Zheng wrote:
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
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
