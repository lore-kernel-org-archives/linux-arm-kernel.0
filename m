From: briannorris@chromium.org (Brian Norris)
Date: Thu,  9 Feb 2017 17:05:18 -0800
Subject: [PATCH v2 3/6] dt-bindings: Document rk3399 Gru/Kevin
In-Reply-To: <20170210010521.78872-1-briannorris@chromium.org>
References: <20170210010521.78872-1-briannorris@chromium.org>
Message-ID: <20170210010521.78872-4-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gru is a base dev board for a family of devices, including Kevin. Both
utilize Rockchip RK3399, and they share much of their design.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6397ab..5328e1f2badc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -56,6 +56,17 @@ Rockchip platforms device tree bindings
       - compatible = "google,veyron-brain-rev0", "google,veyron-brain",
 		     "google,veyron", "rockchip,rk3288";
 
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
 - Google Jaq (Haier Chromebook 11 and more):
     Required root node properties:
       - compatible = "google,veyron-jaq-rev5", "google,veyron-jaq-rev4",
@@ -70,6 +81,15 @@ Rockchip platforms device tree bindings
 		     "google,veyron-jerry-rev3", "google,veyron-jerry",
 		     "google,veyron", "rockchip,rk3288";
 
+- Google Kevin:
+    Required root node properties:
+      - compatible = "google,kevin-rev15", "google,kevin-rev14",
+		     "google,kevin-rev13", "google,kevin-rev12",
+		     "google,kevin-rev11", "google,kevin-rev10",
+		     "google,kevin-rev9", "google,kevin-rev8",
+		     "google,kevin-rev7", "google,kevin-rev6",
+		     "google,kevin", "google,gru", "rockchip,rk3399";
+
 - Google Mickey (Asus Chromebit CS10):
     Required root node properties:
       - compatible = "google,veyron-mickey-rev8", "google,veyron-mickey-rev7",
-- 
2.11.0.483.g087da7b7c-goog
