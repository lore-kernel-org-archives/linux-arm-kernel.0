From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 10 Jul 2018 14:38:31 +0800
Subject: [PATCH 2/2] dt-bindings: arm: mediatek: cleanup MT7623N
 reference boards
In-Reply-To: <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
 <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
Message-ID: <1531204711.26214.1.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-10 at 13:09 +0800, Ryder Lee wrote:
> Cleanup binding document to get rid of unsupported reference boards
> for MT7623N.
> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 7d21ab3..c07ddf4 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -59,9 +59,6 @@ Supported boards:
>  - Reference board for MT7623n with eMMC:
>      Required root node properties:
>        - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
> -- Reference  board for MT7623n with NAND:
> -    Required root node properties:
> -      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";

Acked-by: Sean Wang <sean.wang@mediatek.com>

>  - Bananapi BPI-R2 board:
>        - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
>  - MTK mt8127 tablet moose EVB:
