From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 19:15:01 +0100
Subject: [PATCH v4 11/12] Documentation: arm: update supported Marvell EBU
 processors
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1455646502-23834-12-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we support Armada 37xx, let's add this family of SoC to the
Marvell documentation, and a reference to a link with more details about
those processors. As for Armda 39x, no datasheet is publicly
available at this time.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/arm/Marvell/README | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index ae89b67d8e23..ddbc048bb467 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -118,6 +118,19 @@ EBU Armada family
   Linux kernel mach directory: arch/arm/mach-mvebu
   Linux kernel plat directory: none
 
+EBU Armada family ARMv8
+-----------------------
+
+  Armada 3710/3720 Flavors:
+	88F3710
+	88F3720
+
+  Core: ARM Cortex A53 (ARMv8)
+
+  Homepage     : http://www.marvell.com/embedded-processors/armada-3700/
+
+  Device tree descritpion located in arch/arm64/boot/dts/marvell/armada-37*
+
 Avanta family
 -------------
 
-- 
2.5.0
