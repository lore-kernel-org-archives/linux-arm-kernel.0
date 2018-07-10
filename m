From: john@phrozen.org (John Crispin)
Date: Tue, 10 Jul 2018 07:59:24 +0200
Subject: [PATCH 2/2] dt-bindings: arm: mediatek: cleanup MT7623N reference
 boards
In-Reply-To: <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
 <99c1fce76e7ec4984c232bc0bdbd0fadbb86b0dc.1531199139.git.ryder.lee@mediatek.com>
Message-ID: <194425ed-4ba8-094e-5b54-17ca74847b5f@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/18 07:09, Ryder Lee wrote:
> Cleanup binding document to get rid of unsupported reference boards
> for MT7623N.
>
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
> ---
>   Documentation/devicetree/bindings/arm/mediatek.txt | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 7d21ab3..c07ddf4 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -59,9 +59,6 @@ Supported boards:
>   - Reference board for MT7623n with eMMC:
>       Required root node properties:
>         - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
> -- Reference  board for MT7623n with NAND:
> -    Required root node properties:
> -      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
>   - Bananapi BPI-R2 board:
>         - compatible = "bananapi,bpi-r2", "mediatek,mt7623";
>   - MTK mt8127 tablet moose EVB:
