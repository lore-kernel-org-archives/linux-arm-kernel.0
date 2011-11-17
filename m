From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Thu, 17 Nov 2011 10:28:39 +0100
Subject: [PATCH] [ARM] APF9328 needs CONFIG_MTD_CFI_INTELEXT to boot on its
 NOR FLASH.
Message-ID: <1321522119-17571-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5f7f9c2..144f007 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -112,6 +112,7 @@ config MACH_APF9328
 	bool "APF9328"
 	select SOC_IMX1
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select MTD_CFI_INTELEXT
 	help
 	  Say Yes here if you are using the Armadeus APF9328 development board
 
-- 
1.7.3.4
