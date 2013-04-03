From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:49 +0800
Subject: [PATCH V6 6/9] ARM: dts: tegra: whistler: add wakeup source for KBC
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988712-24797-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding KBC as a wakeup source for Whistler board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V6:
* no change
V5:
* no change
V4:
* no change
V3:
* no change
V2:
* no change
---
 arch/arm/boot/dts/tegra20-whistler.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 99746c6..47c7a82 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -539,6 +539,7 @@
 		nvidia,repeat-delay-ms = <160>;
 		nvidia,kbc-row-pins = <0 1 2>;
 		nvidia,kbc-col-pins = <16 17>;
+		nvidia,wakeup-source;
 		linux,keymap = <0x00000074	/* KEY_POWER */
 				0x01000066	/* KEY_HOME */
 				0x0101009E	/* KEY_BACK */
-- 
1.8.2
