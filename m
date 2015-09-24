From: erin.lo@mediatek.com (erin.lo)
Date: Thu, 24 Sep 2015 11:15:59 +0800
Subject: [PATCH 1/2] Document: DT: Add bindings for mediatek MT2701 SoC
 Platform
In-Reply-To: <1442998570-54031-2-git-send-email-erin.lo@mediatek.com>
References: <1442998570-54031-1-git-send-email-erin.lo@mediatek.com>
 <1442998570-54031-2-git-send-email-erin.lo@mediatek.com>
Message-ID: <1443064559.23409.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-23 at 16:56 +0800, erin.lo at mediatek.com wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> This adds a DT binding documentation for the MT2701 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt                 | 4 ++++
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt | 1 +
>  Documentation/devicetree/bindings/serial/mtk-uart.txt              | 5 +++--
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt     | 5 +++--
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt             | 6 +++++-
>  5 files changed, 16 insertions(+), 5 deletions(-)
> 

[snip...]

> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 2d47add..f5effb7 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -9,8 +9,9 @@ Required properties:
>    * "mediatek,mt6589-uart" for MT6589 compatible UARTS
>    * "mediatek,mt6582-uart" for MT6582 compatible UARTS
>    * "mediatek,mt6580-uart" for MT6580 compatible UARTS
> -  * "mediatek,mt6577-uart" for all compatible UARTS (MT8173, MT6795,
> -        MT6589, MT6582, MT6580, MT6577)
> +  * "mediatek,mt6577-uart" for all compatible UARTS (MT8173, MT6589, MT6582,


MT6795 will be added back in next version.

Regards,
-Erin
