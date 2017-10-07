From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  7 Oct 2017 18:29:40 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC
 controller
In-Reply-To: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
References: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
Message-ID: <20171007162940.14595-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the new Amlogic Meson MX SDIO/MMC controller driver, which
typically connects to the SD card and SDIO wifi module.
The driver is enabled as built-in to allow booting from the SD card.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0cacdbf84a71..339f67463816 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -727,6 +727,7 @@ CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MMC_MESON_MX_SDIO=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
-- 
2.14.2
