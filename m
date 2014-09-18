From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 18 Sep 2014 15:09:17 +0200
Subject: [PATCH v2 5/7] dt-bindings: add more chips in documentation for
 Mediatek SoC
In-Reply-To: <1410963854-17154-6-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1410963854-17154-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1410963854-17154-6-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <541AD97D.2090304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry I just saw some more issues:

On 17/09/14 16:24, Joe.C wrote:
> From: "Joe.C" <yingjoe.chen@mediatek.com>
> 
> Add MT8127 & MT8135 from Mediatek.
> 
> Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index fa25226..40a9745 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -1,10 +1,13 @@
> -Mediatek MT6589 Platforms Device Tree Bindings
> +Mediatek Platforms Device Tree Bindings
>  
> -Boards with a SoC of the Mediatek MT6589 shall have the following property:
> +Boards with a SoC of the Mediatek shall have the following property:
>  
>  Required root node property:
>  
> -compatible: must contain "mediatek,mt6589"
> +compatible: Must contain one of
> +   "mediatek,mt6589"
> +   "mediatek,mt8127"
> +   "mediatek,mt8135"
>  
>  
>  Supported boards:

Please document the supported boards and add a compatible string in the
dts files for moose and evbp1 boards.

Thanks,
Matthias

> 
