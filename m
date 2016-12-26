From: puck.chen@hisilicon.com (Chen Feng)
Date: Mon, 26 Dec 2016 17:36:11 +0800
Subject: [RESEND 1/2] document: dt: add binding for Hi3660 SoC
Message-ID: <1482744972-56622-1-git-send-email-puck.chen@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for hisilicon Hi3660 SoC and HiKey960 Board.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 3f81575..7cf2847 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -8,6 +8,10 @@ Hi6220 SoC
 Required root node properties:
 	- compatible = "hisilicon,hi6220";
 
+Hi3660 SoC
+Required root node properties:
+	- compatible = "hisilicon,hi3660";
+
 HiKey Board
 Required root node properties:
 	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
-- 
1.9.1
