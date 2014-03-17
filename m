From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Mar 2014 07:14:37 +0900
Subject: [PATCH v3 3/3] Documentation: DT: add new entry for Samsung GH7 SoC
 and SSDK board
In-Reply-To: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
References: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1395094477-8921-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/devicetree/bindings/arm/samsung-boards.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung-boards.txt
index 2168ed3..d6b5493 100644
--- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
@@ -16,3 +16,12 @@ Optional:
 		compatible = "samsung,secure-firmware";
 		reg = <0x0203F000 0x1000>;
 	};
+
+* Samsung's GH7 based SSDK-GH7 evaluation board
+
+SSDK-GH7 evaluation board is based on Samsung's GH7 SoC which has ARMv8 cores.
+
+Required root node properties:
+    - compatible = should be one or more of the following.
+        (a) "samsung,ssdk-gh7" - for Samsung's SSDK-GH7 eval board.
+        (b) "samsung,gh7"  - for boards based on GH7 SoC.
-- 
1.8.2.1.339.g52a3e01
