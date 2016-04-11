From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Mon, 11 Apr 2016 17:20:09 +0800
Subject: [PATCH v2 1/2] dt-bindings: phy-mt65xx-usb: add support for
 mt2701 platform
In-Reply-To: <1460360490-18606-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1460360490-18606-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1460366409.10419.29.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add Matthias

sorry

On Mon, 2016-04-11 at 15:41 +0800, Chunfeng Yun wrote:
> A new compatible string, "mediatek,mt2701-u3phy", is added.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mt65xx-usb.txt     |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> index 00100cf..33a2b1e 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mt65xx-usb.txt
> @@ -4,7 +4,9 @@ mt65xx USB3.0 PHY binding
>  This binding describes a usb3.0 phy for mt65xx platforms of Medaitek SoC.
>  
>  Required properties (controller (parent) node):
> - - compatible	: should be "mediatek,mt8173-u3phy"
> + - compatible	: should be one of
> +		  "mediatek,mt2701-u3phy"
> +		  "mediatek,mt8173-u3phy"
>   - reg		: offset and length of register for phy, exclude port's
>  		  register.
>   - clocks	: a list of phandle + clock-specifier pairs, one for each
