From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 20 Oct 2015 16:50:08 -0500
Subject: [PATCH 4/5] ARM: keystone: defconfig: Enable MMC support
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Message-ID: <1445377809-12516-4-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer Keystone 2 devices support MMC and can boot from MMC. Therefore,
enable MMC support along with MMC OMAP HS whose driver is reused.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index e0e0365..ed3e83e 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -137,6 +137,8 @@ CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_MMC=y
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_HWMON is not set
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
-- 
2.6.1
