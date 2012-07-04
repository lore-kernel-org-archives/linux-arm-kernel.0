From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 13:37:50 -0300
Subject: [PATCH] ARM: mxs_defconfig: Enable RTC driver
Message-ID: <1341419870-11750-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let RTC driver driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 94198c5..1450f64 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -114,6 +114,7 @@ CONFIG_MMC=y
 CONFIG_MMC_MXS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=m
+CONFIG_RTC_DRV_STMP=y
 CONFIG_DMADEVICES=y
 CONFIG_MXS_DMA=y
 CONFIG_EXT3_FS=y
-- 
1.7.1
