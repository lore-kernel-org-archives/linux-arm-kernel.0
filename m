From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Tue, 25 Sep 2012 00:01:31 +0530
Subject: [PATCH v2] ARM: OMAP2+: Add am335x evm and bone targets to common
 Makefile
Message-ID: <1348511491-455-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds am335x-evm and am335x-bone dtb targets to
'make dtbs', just like other platforms.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
Changes from V1:
	- Move target to common Makefile instead of
	  the per-platform file.

 arch/arm/boot/dts/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d4ad2df..6f2dae8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -75,7 +75,9 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap4-pandaES.dtb \
 	omap4-var_som.dtb \
 	omap4-sdp.dtb \
-	omap5-evm.dtb
+	omap5-evm.dtb \
+	am335x-evm.dtb \
+	am335x-bone.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
--
1.7.0.4
