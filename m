From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 21 Oct 2015 10:30:51 +0900
Subject: [PATCH 2/2] dt-bindings: EXYNOS: Document compatibles from other
 vendors
In-Reply-To: <1445391051-3727-1-git-send-email-k.kozlowski@samsung.com>
References: <1445391051-3727-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1445391051-3727-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document compatibles used on other Exynos-based boards (non-Samsung):
FriendlyARM, Google, Hardkernel and Insignal.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Hakjoo Kim <ruppi.kim@hardkernel.com>
---
 .../bindings/arm/samsung/samsung-boards.txt        | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 43589d2466a7..da078702ae73 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -16,7 +16,49 @@ Required root node properties:
 	- "samsung,sd5v1"	- for Exynos5440-based Samsung board.
 	- "samsung,ssdk5440"	- for Exynos5440-based Samsung board.
 
-Optional:
+* Other companies Exynos SoC based
+  * FriendlyARM
+        - "friendlyarm,tiny4412"  - for Exynos4412-based FriendlyARM
+                                    TINY4412 board.
+
+  * Google
+        - "google,pi"             - for Exynos5800-based Google Peach Pi
+                                    Rev 10+ board,
+          also: "google,pi-rev16", "google,pi-rev15", "google,pi-rev14",
+		"google,pi-rev13", "google,pi-rev12", "google,pi-rev11",
+                "google,pi-rev10", "google,peach".
+
+        - "google,pit"            - for Exynos5420-based Google Peach Pit
+                                    Rev 6+ (Exynos5420),
+          also: "google,pit-rev16", "google,pit-rev15", "google,pit-rev14",
+                "google,pit-rev13", "google,pit-rev12", "google,pit-rev11",
+                "google,pit-rev10", "google,pit-rev9", "google,pit-rev8",
+                "google,pit-rev7", "google,pit-rev6", "google,peach".
+
+        - "google,snow-rev4"      - for Exynos5250-based Google Snow board,
+          also: "google,snow"
+        - "google,snow-rev5"      - for Exynos5250-based Google Snow
+                                    Rev 5+ board.
+        - "google,spring"         - for Exynos5250-based Google Spring board.
+
+  * Hardkernel
+        - "hardkernel,odroid-u3"  - for Exynos4412-based Hardkernel Odroid U3.
+        - "hardkernel,odroid-x"   - for Exynos4412-based Hardkernel Odroid X.
+        - "hardkernel,odroid-x2"  - for Exynos4412-based Hardkernel Odroid X2.
+        - "hardkernel,odroid-xu3" - for Exynos5422-based Hardkernel Odroid XU3.
+        - "hardkernel,odroid-xu3-lite" - for Exynos5422-based Hardkernel
+                                         Odroid XU3 Lite board.
+        - "hardkernel,odroid-xu4" - for Exynos5422-based Hardkernel Odroid XU4.
+
+  * Insignal
+        - "insignal,arndale"      - for Exynos5250-based Insignal Arndale board.
+        - "insignal,arndale-octa" - for Exynos5420-based Insignal Arndale
+                                    Octa board.
+        - "insignal,origen"       - for Exynos4210-based Insignal Origen board.
+        - "insignal,origen4412    - for Exynos4412-based Insignal Origen board.
+
+
+Optional nodes:
     - firmware node, specifying presence and type of secure firmware:
         - compatible: only "samsung,secure-firmware" is currently supported
         - reg: address of non-secure SYSRAM used for communication with firmware
-- 
1.9.1
