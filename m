From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Dec 2015 16:20:10 +0800
Subject: [PATCH 1/4] irqchip/sunxi-nmi: Rename binding doc filename to
 allwinner, sunxi-nmi.txt
In-Reply-To: <1449130813-22400-1-git-send-email-wens@csie.org>
References: <1449130813-22400-1-git-send-email-wens@csie.org>
Message-ID: <1449130813-22400-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NMI controller is found in all Allwinner multi-core SoCs. It is not
limited to sun[67]i, nor is it always found in the "system controller"
block. On sun[68]i, it is in the RTC block, while on sun9i, it is in the
PRCM block.

Drop these 2 specific bits from the binding doc filename.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../{allwinner,sun67i-sc-nmi.txt => allwinner,sunxi-nmi.txt}              | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{allwinner,sun67i-sc-nmi.txt => allwinner,sunxi-nmi.txt} (100%)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/interrupt-controller/allwinner,sun67i-sc-nmi.txt
rename to Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
-- 
2.6.2
