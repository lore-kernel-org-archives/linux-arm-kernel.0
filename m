From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Mon, 20 Jun 2016 16:04:13 +0300
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable AHCI_IMX
Message-ID: <1466427854-21265-1-git-send-email-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wandboard Quad comes with a SATA port. Enable the IMX SATA driver by
default to make it easy to have the root filesystem on it.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee7c884..6efcbc7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -214,6 +214,7 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_ST=y
+CONFIG_AHCI_IMX=y
 CONFIG_AHCI_SUNXI=y
 CONFIG_AHCI_TEGRA=y
 CONFIG_SATA_HIGHBANK=y
-- 
2.8.2
