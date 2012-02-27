From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Feb 2012 15:44:09 +0800
Subject: [PATCH] ARM: defconfig: imx_v6_v7: build in REGULATOR_FIXED_VOLTAGE
Message-ID: <1330328649-2174-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices on some imx boards are supplied by fixed voltage, so
build REGULATOR_FIXED_VOLTAGE support in.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fa236a2..3cd6069 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -124,6 +124,7 @@ CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_MC13XXX=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.5.4
