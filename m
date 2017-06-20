From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 20 Jun 2017 12:12:27 +0200
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT2712 soc
 platform
In-Reply-To: <1497946867-25708-2-git-send-email-leilk.liu@mediatek.com>
References: <1497946867-25708-1-git-send-email-leilk.liu@mediatek.com>
 <1497946867-25708-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <56744779-5cde-04e3-984a-704e7707d072@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/06/17 10:21, Leilk Liu wrote:
> This patch adds a DT binding documentation for the MT2712 soc.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> index c0b1f01..e0318cf 100644
> --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -3,6 +3,7 @@ Binding for MTK SPI controller
>   Required properties:
>   - compatible: should be one of the following.
>       - mediatek,mt2701-spi: for mt2701 platforms
> +    - mediatek,mt2712-spi: for mt2712 platforms
>       - mediatek,mt6589-spi: for mt6589 platforms
>       - mediatek,mt7622-spi: for mt7622 platforms
>       - mediatek,mt8135-spi: for mt8135 platforms
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
