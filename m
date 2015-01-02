From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 2 Jan 2015 11:24:06 +0100
Subject: [PATCH 3/3] DTS: serial: Add bindings document for the Mediatek
 UARTs
In-Reply-To: <1413983529-21887-4-git-send-email-eddie.huang@mediatek.com>
References: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
 <1413983529-21887-4-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CABuKBeL9r6Gm19fdKwx5HUDiyJKgC1xcLp1j1B9JbOa=c+3Epg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-22 15:12 GMT+02:00 Eddie Huang <eddie.huang@mediatek.com>:
> This patch add s devicetree document for Mediatek UART.
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 48358a3..0eebbfe 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -2,6 +2,8 @@
>
>  Required properties:
>  - compatible should contain:
> +  * "mediatek,mt8135-uart" for MT8135 compatible UARTS
> +  * "mediatek,mt8127-uart" for MT8127 compatible UARTS
>    * "mediatek,mt6589-uart" for MT6589 compatible UARTS
>    * "mediatek,mt6582-uart" for MT6582 compatible UARTS
>    * "mediatek,mt6577-uart" for all compatible UARTS (MT6589, MT6582, MT6577)
> --
> 1.8.1.1.dirty
>

Applied to v3.20-next/dts, thanks.

-- 
motzblog.wordpress.com
