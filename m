From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 11 Dec 2013 19:28:40 -0300
Subject: [PATCH] ARM: mvebu: config: Enable NAND support
In-Reply-To: <1386800920-7096-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386800920-7096-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1386800920-7096-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the pxa3xx-nand driver, which now supports the NAND controller
in Armada 370/XP SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 6fcb5c8..0f4511d 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -55,6 +55,8 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_PXA3xx=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
-- 
1.8.1.5
