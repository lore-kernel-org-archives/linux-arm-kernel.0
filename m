From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 20 Dec 2016 22:20:05 +0100
Subject: [PATCH] devicetree: bindings: clk: mvebu: fix description for sata1
 on Armada XP
Message-ID: <20161220212005.26139-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA Host 0 clock is (as correctly documented) id 15/sata0.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index cb8542d910b3..5142efc8099d 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -117,7 +117,7 @@ ID	Clock	Peripheral
 25	tdm	Time Division Mplx
 28	xor1	XOR DMA 1
 29	sata1lnk
-30	sata1	SATA Host 0
+30	sata1	SATA Host 1
 
 The following is a list of provided IDs for Dove:
 ID	Clock	Peripheral
-- 
2.10.2
