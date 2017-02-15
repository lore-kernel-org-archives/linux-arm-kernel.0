From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:19 +0100
Subject: [PATCH 02/11] Documentation: devicetree: arm: Document Actions Semi
 S500
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/acts.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/acts.txt

diff --git a/Documentation/devicetree/bindings/arm/acts.txt b/Documentation/devicetree/bindings/arm/acts.txt
new file mode 100644
index 0000000..a34d647
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/acts.txt
@@ -0,0 +1,19 @@
+Actions Semi platforms device tree bindings
+-------------------------------------------
+
+
+S500 SoC
+========
+
+Required root node properties:
+
+ - compatible :  "acts,s500"
+
+
+Modules:
+
+ - LeMaker Guitar: "lemaker,guitar"
+
+Boards:
+
+ - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
-- 
2.10.2
