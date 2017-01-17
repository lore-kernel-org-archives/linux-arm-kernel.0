From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 17 Jan 2017 13:26:04 +0100
Subject: [PATCH v2 02/14] ARM: davinci_all_defconfig: enable SATA modules
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484655976-25382-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the da850-ahci driver to davinci defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 8806754..a1b9c58 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -78,6 +78,8 @@ CONFIG_IDE=m
 CONFIG_BLK_DEV_PALMCHIP_BK3710=m
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
+CONFIG_ATA=m
+CONFIG_AHCI_DA850=m
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
-- 
2.9.3
