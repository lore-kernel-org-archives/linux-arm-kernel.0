From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 11:59:43 +0530
Subject: [PATCH 3/3] Documentation: DT: add new entry for Samsung GH7 SoC and
 SSDK board
In-Reply-To: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1392100183-30930-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/devicetree/bindings/arm/samsung-boards.txt |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung-boards.txt
index 2168ed3..9284db3 100644
--- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
@@ -16,3 +16,13 @@ Optional:
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
+
-- 
1.7.10.4
