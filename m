From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 31 Dec 2012 11:49:16 +0800
Subject: [PATCH 1/2] ARM: dts: add missing imx dtb targets
Message-ID: <1356925757-5704-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing imx dtb targets, so that make dtbs can cover all imx dtbs.
It's pretty useful for testing dts changes.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0a0ec07..e3ae5e2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -79,7 +79,11 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-mirabox.dtb \
 	armada-xp-db.dtb \
 	armada-xp-openblocks-ax3-4.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx27-pdk.dtb \
+dtb-$(CONFIG_ARCH_MXC) += \
+	imx25-karo-tx25.dtb \
+	imx27-apf27.dtb \
+	imx27-pdk.dtb \
+	imx31-bug.dtb \
 	imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
-- 
1.7.9.5
