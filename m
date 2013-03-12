From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 12 Mar 2013 12:03:28 +0800
Subject: [PATCH V2 6/9] ARM: dts: tegra: whistler: add wakeup source for KBC
Message-ID: <1363061008-9443-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding KBC as a wakeup source for Whistler board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/boot/dts/tegra20-whistler.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 5762188..4afcae1 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -526,6 +526,7 @@
 		nvidia,repeat-delay-ms = <160>;
 		nvidia,kbc-row-pins = <0 1 2>;
 		nvidia,kbc-col-pins = <16 17>;
+		nvidia,wakeup-source;
 		linux,keymap = <0x00000074	/* KEY_POWER */
 				0x01000066	/* KEY_HOME */
 				0x0101009E	/* KEY_BACK */
-- 
1.8.1.5
