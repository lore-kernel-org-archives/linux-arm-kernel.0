From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 27 Jun 2015 09:25:44 -0700
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable BRCMNAND driver
In-Reply-To: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com>
References: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1435422344-31059-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom NAND driver is used by brcmstb, bcm63xx, bcm5301x and
Cygnus/iProc under mach-bcm, this is enough critical mass to enable it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fd6a6d23bc20..6d83a1bf0c74 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -169,6 +169,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
+CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
-- 
2.1.0
