From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 20:24:39 -0300
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Add support for
 CONFIG_REGULATOR_FIXED_VOLTAGE
Message-ID: <1334186679-22925-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for CONFIG_REGULATOR_FIXED_VOLTAGE.

Without this option the mx27_3ds cannot have the external Ethernet functional
due to the need of smsc regulators.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index b5ac644..6b31cb6 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -112,6 +112,7 @@ CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_MC13XXX=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_FB=y
-- 
1.7.1
