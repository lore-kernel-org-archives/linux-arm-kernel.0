From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 19 Jan 2013 15:07:44 +0530
Subject: [PATCH] ARM: tegra: DTS: seaboard: remove unnecessarily text
Message-ID: <1358588264-1860-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is unnecessarily text in the keymap table. Removing this.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 2e87330..d4e4ff2 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -705,7 +705,7 @@
 				0x0E030010	/* KEY_Q */
 				0x0E04003E	/* KEY_F4 */
 				0x0E05003D	/* KEY_F3 */
-				0x0E060002	/* KEY_1 */1
+				0x0E060002	/* KEY_1 */
 				0x0E070041	/* KEY_F7 */
 
 				0x0F000001	/* KEY_ESC */
-- 
1.7.1.1
