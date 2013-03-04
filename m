From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:41:21 +0800
Subject: [PATCH 08/10] ARM: dts: tegra: whistler: add wakeup source for KBC
Message-ID: <1362397281-6044-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding KBC as a wakeup source for Whistler board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra20-whistler.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 667c8a2..dd8c04b 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -534,6 +534,7 @@
 		nvidia,repeat-delay-ms = <160>;
 		nvidia,kbc-row-pins = <0 1 2>;
 		nvidia,kbc-col-pins = <16 17>;
+		nvidia,wakeup-source;
 		linux,keymap = <0x00000074	/* KEY_POWER */
 				0x01000066	/* KEY_HOME */
 				0x0101009E	/* KEY_BACK */
-- 
1.8.1.1
