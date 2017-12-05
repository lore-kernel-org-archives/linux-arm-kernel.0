From: vigneshr@ti.com (Vignesh R)
Date: Tue, 5 Dec 2017 14:49:40 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: Add configs for peripherals on
 Keystone2 SoCs
Message-ID: <20171205091940.22957-1-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Cadence QSPI present on 66AK2G SoC and Keystone USB PHY driver
for K2E.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 992a8a5da065..c4f4f6682ea5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -185,6 +185,7 @@ CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
+CONFIG_SPI_CADENCE_QUADSPI=m
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
@@ -675,6 +676,7 @@ CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_AB8500_USB=y
+CONFIG_KEYSTONE_USB_PHY=m
 CONFIG_NOP_USB_XCEIV=m
 CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
-- 
2.15.1
