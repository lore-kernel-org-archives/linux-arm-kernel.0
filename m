From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 21 May 2014 23:04:53 -0700
Subject: [PATCH 1/3] ARM: dts: imx6: ventana: fix include typo
Message-ID: <1400738695-32663-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo and include the right dtsi file for the gw51xx board.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw51xx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-gw51xx.dts b/arch/arm/boot/dts/imx6q-gw51xx.dts
index af4929a..0e1406e 100644
--- a/arch/arm/boot/dts/imx6q-gw51xx.dts
+++ b/arch/arm/boot/dts/imx6q-gw51xx.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 #include "imx6q.dtsi"
-#include "imx6qdl-gw54xx.dtsi"
+#include "imx6qdl-gw51xx.dtsi"
 
 / {
 	model = "Gateworks Ventana i.MX6 Quad GW51XX";
-- 
1.8.3.2
