From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 28 Oct 2014 12:24:20 +0000
Subject: [PATCH v2 2/4] dt-bindings: Document Marsboard RK3066 in Rockchip
 platforms dt-bindings
In-Reply-To: <1414499062-23875-1-git-send-email-romain.perier@gmail.com>
References: <1414499062-23875-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1414499062-23875-2-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
Changes since v1:
  - Replaced hoayuelectronics by hoayu as suggested by the vendor-prefix doc in dt-bindings

 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 857f126..eaa3d1a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -1,6 +1,10 @@
 Rockchip platforms device tree bindings
 ---------------------------------------
 
+- MarsBoard RK3066 board:
+    Required root node properties:
+      - compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
+
 - bq Curie 2 tablet:
     Required root node properties:
       - compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
-- 
1.9.1
