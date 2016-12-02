From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:30 -0800
Subject: [PATCH 6/9] dt-bindings: Document rk3399 Gru/Kevin
In-Reply-To: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
Message-ID: <1480645653-36943-7-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gru is a base dev board for a family of devices, including Kevin. Both
utilize Rockchip RK3399, and they share much of their design.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6397ab..830e13f5890c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -99,6 +99,26 @@ Rockchip platforms device tree bindings
 		     "google,veyron-speedy-rev3", "google,veyron-speedy-rev2",
 		     "google,veyron-speedy", "google,veyron", "rockchip,rk3288";
 
+- Google Gru (dev-board):
+    Required root node properties:
+      - compatible = "google,gru-rev15", "google,gru-rev14",
+		     "google,gru-rev13", "google,gru-rev12",
+		     "google,gru-rev11", "google,gru-rev10",
+		     "google,gru-rev9", "google,gru-rev8",
+		     "google,gru-rev7", "google,gru-rev6",
+		     "google,gru-rev5", "google,gru-rev4",
+		     "google,gru-rev3", "google,gru-rev2",
+		     "google,gru", "rockchip,rk3399";
+
+- Google Kevin:
+    Required root node properties:
+      - compatible = "google,kevin-rev15", "google,kevin-rev14",
+		     "google,kevin-rev13", "google,kevin-rev12",
+		     "google,kevin-rev11", "google,kevin-rev10",
+		     "google,kevin-rev9", "google,kevin-rev8",
+		     "google,kevin-rev7", "google,kevin-rev6",
+		     "google,kevin", "google,gru", "rockchip,rk3399";
+
 - mqmaker MiQi:
     Required root node properties:
       - compatible = "mqmaker,miqi", "rockchip,rk3288";
-- 
2.8.0.rc3.226.g39d4020
