From: steven.lin1@broadcom.com (Steve Lin)
Date: Wed, 15 Mar 2017 16:59:35 -0400
Subject: [PATCH] ARM: dts: BCM953012HR: Add ethernet aliases
Message-ID: <1489611575-18684-1-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding ethernet aliases.  These are used, for example, by bootloaders,
to modify the MAC addresses in the device tree.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
---
 arch/arm/boot/dts/bcm953012hr.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 85f9b0b..766aa71 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -41,6 +41,9 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
 	};
 
 	chosen {
-- 
2.1.0
