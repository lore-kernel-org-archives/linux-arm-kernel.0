From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 24 Sep 2017 16:45:12 +0100
Subject: [PATCH 1/3] dt-bindings: adc: mt2712: add binding document
In-Reply-To: <1505957212-13402-2-git-send-email-zhiyong.tao@mediatek.com>
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
 <1505957212-13402-2-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <20170924164512.5e06cb8f@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Sep 2017 09:26:50 +0800
Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> The commit adds mt2712 compatible node in binding document.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Given just how trivial this is, I'm not going to waste Rob or Marks
time by waiting for them to look at it.  I did tweak the patch
title to '... binding documentation' to reflect the fact this
isn't a new file which 'binding document' sort of implied.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> index 64dc484..0df9bef 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> @@ -12,6 +12,7 @@ for the Thermal Controller which holds a phandle to the AUXADC.
>  Required properties:
>    - compatible: Should be one of:
>      - "mediatek,mt2701-auxadc": For MT2701 family of SoCs
> +    - "mediatek,mt2712-auxadc": For MT2712 family of SoCs
>      - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
>      - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
>    - reg: Address range of the AUXADC unit.
