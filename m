From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 12:43:43 -0500
Subject: [PATCH] dt-bindings: watchdog: mediatek: add support for
 MediaTek MT7623 and MT7622 SoC
In-Reply-To: <b0058a0a9f948f17edf3c1a476665c715922ebc3.1501830388.git.sean.wang@mediatek.com>
References: <b0058a0a9f948f17edf3c1a476665c715922ebc3.1501830388.git.sean.wang@mediatek.com>
Message-ID: <20170810174343.7pejhh7wxkcaf3zj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 03:14:07PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This updates dt-binding documentation for MediaTek MT7622 and
> MT7623 SoC. For the both SoCs supported all rely on the fallback
> binding of the case with "mediatek,mt6589-wdt".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
