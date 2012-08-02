From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  2 Aug 2012 17:13:47 +0200
Subject: [PATCH] arm: mvebu: fix typo in .dtsi comment for Armada XP SoCs
Message-ID: <1343920427-26128-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comment was wrongly referring to Armada 370 while the file is
related to Armada XP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index e1fa7e6..71d6b5d 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -12,7 +12,7 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  *
- * Contains definitions specific to the Armada 370 SoC that are not
+ * Contains definitions specific to the Armada XP SoC that are not
  * common to all Armada SoCs.
  */
 
-- 
1.7.9.5
