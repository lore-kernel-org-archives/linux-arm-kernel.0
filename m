From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:35:56 +0200
Subject: [PATCH 1/9] ARM: tegra: Cardhu device-tree comment spelling fix
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <cb3321c697591c3b2ae2ad799282448cff4bef21.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index a1b682e..6f86820 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -12,7 +12,7 @@
  * tegra30-cardhu-a04.dts.
  * The identification of board is done in two ways, by looking the sticker
  * on PCB and by reading board id eeprom.
- * The stciker will have number like 600-81291-1000-002 C.3. In this 4th
+ * The sticker will have number like 600-81291-1000-002 C.3. In this 4th
  * number is the fab version like here it is 002 and hence fab version A02.
  * The (downstream internal) U-Boot of Cardhu display the board-id as
  * follows:
-- 
1.9.3
