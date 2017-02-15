From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:27 +0100
Subject: [PATCH 10/11] Documentation: devicetree: arm: Document Actions Semi
 S900
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-11-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/acts.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/acts.txt b/Documentation/devicetree/bindings/arm/acts.txt
index a34d647..cdbfe12 100644
--- a/Documentation/devicetree/bindings/arm/acts.txt
+++ b/Documentation/devicetree/bindings/arm/acts.txt
@@ -17,3 +17,16 @@ Modules:
 Boards:
 
  - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
+
+
+S900 SoC
+========
+
+Required root node properties:
+
+- compatible :  "acts,s900"
+
+
+Boards:
+
+ - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
-- 
2.10.2
