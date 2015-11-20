From: leilk.liu@mediatek.com (Leilk Liu)
Date: Fri, 20 Nov 2015 10:21:17 +0800
Subject: [PATCH 2/4] spi: mediatek: remove unrequired description
In-Reply-To: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1447986080-31410-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cs-gpios isn't required with patch "spi: mediatek: single
device does not require cs_gpios", so modify the description.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index fba8334..60a183c 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -29,7 +29,7 @@ Required properties:
   muxes clock, and "spi-clk" for the clock gate.
 
 Optional properties:
--cs-gpios: see spi-bus.txt, only required for MT8173.
+-cs-gpios: see spi-bus.txt.
 
 - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
   controller used. This is an array, the element value should be 0~3,
-- 
1.7.9.5
