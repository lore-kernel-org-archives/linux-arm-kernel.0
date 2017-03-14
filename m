From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 14 Mar 2017 12:14:15 +0100
Subject: [PATCH v2 4/4] ARM: omap2plus_defconfig: enable ahci-dm816 module
In-Reply-To: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
References: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1489490055-2318-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is now supported on the dm8168-evm board, so enable it in
the defconfig for omap2+.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index f2462a6..3944aa9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -141,6 +141,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_DM816=m
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
-- 
2.9.3
