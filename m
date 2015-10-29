From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu, 29 Oct 2015 16:27:29 -0400
Subject: [PATCH v2 4/5] ARM: imx_v6_v7_defconfig: add TS-4800 watchdog and
 syscon
In-Reply-To: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1446150450-22093-5-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b47863d..7adc8b7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -190,11 +190,13 @@ CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_TS4800_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_STMPE=y
+CONFIG_MFD_TS4800_SYSCON=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
-- 
2.5.0
