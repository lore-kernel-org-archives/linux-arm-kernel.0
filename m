From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 20 Jul 2018 16:30:11 +0200
Subject: [PATCH 5/6] ARM: multi_v7_defconfig: enable tegra raw nand driver
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
Message-ID: <20180720143012.7740-5-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Now with everything being merged actually enable it.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index beacb02c734b..27a621eaa8dd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -190,6 +190,7 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
+CONFIG_MTD_NAND_TEGRA=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_MTD_UBI=y
-- 
2.14.4
