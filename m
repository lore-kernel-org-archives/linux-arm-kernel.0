From: okamura.dai@socionext.com (okamura.dai at socionext.com)
Date: Tue, 28 Nov 2017 10:41:32 +0000
Subject: [PATCH] arm64: dts: uniphier: correct on-board device IRQ number for
 PXs3
Message-ID: <20171128103934.24034-1-okamura.dai@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ba5b5034bd29 ("arm64: dts: uniphier: route on-board device IRQ
to GPIO controller for PXs3") has incorrect update.

Fixes: ba5b5034bd29 ("arm64: dts: uniphier: route on-board device IRQ to GPIO controller for PXs3")
Signed-off-by: Dai Okamura <okamura.dai@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 864feeb35180..6b5b6c285964 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -39,7 +39,7 @@
 
 &ethsc {
 	interrupt-parent = <&gpio>;
-	interrupts = <0 8>;
+	interrupts = <4 8>;
 };
 
 &serial0 {
-- 
2.13.0
