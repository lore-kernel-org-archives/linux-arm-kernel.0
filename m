From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Tue, 24 Nov 2015 13:00:52 -0500
Subject: [PATCH v5 4/5] ARM: imx_v6_v7_defconfig: add TS-4800 watchdog
In-Reply-To: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1448388053-30661-5-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TS-4800, based on an IMX.515, needs its watchdog support in order to
work.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 79194c6..8968166 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -195,6 +195,7 @@ CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_TS4800_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
 CONFIG_MFD_MC13XXX_SPI=y
-- 
2.5.0
