From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:06 +0900
Subject: [PATCH 1/7] ARM: shmobile: multiplatform: Enable MSIOF in defconfig
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
Message-ID: <d477a4a2fcbf59feb617de9502ae8b862e1578ed.1397627278.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 83b0725..2a27d46 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -78,6 +78,7 @@ CONFIG_I2C_GPIO=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
+CONFIG_SPI_SH_MSIOF=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
-- 
1.8.5.2
