From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:34:39 +0100
Subject: [PATCH 4/7] ARM: multi_v7_defconfig: add RN5T618 PMIC family support
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Message-ID: <20180318203442.19759-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to successfully boot Colibri iMX7 which is using
the Ricoh RN5T567 PMIC.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc142dc75092..66c32741a130 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -477,6 +477,7 @@ CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_RN5T618_WATCHDOG=y
 CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_IMX2_WDT=y
@@ -512,6 +513,7 @@ CONFIG_MFD_RK808=y
 CONFIG_MFD_PM8XXX=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
+CONFIG_MFD_RN5T618=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_PALMAS=y
@@ -548,6 +550,7 @@ CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
+CONFIG_REGULATOR_RN5T618=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TI_ABB=y
-- 
2.16.2
