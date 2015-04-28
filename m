From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 28 Apr 2015 13:59:44 +0300
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: enable Conexant Digicolor
 platform
In-Reply-To: <cover.1430217994.git.baruch@tkos.co.il>
References: <cover.1430217994.git.baruch@tkos.co.il>
Message-ID: <366dfc6d721aee3d930b9c4ce7abd2b02b3137df.1430217995.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ab86655c1f4b..46124579ba8c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -30,6 +30,7 @@ CONFIG_ARCH_BERLIN=y
 CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
+CONFIG_ARCH_DIGICOLOR=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
@@ -257,6 +258,8 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
+CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
 CONFIG_SERIAL_ST_ASC=y
 CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
@@ -266,6 +269,7 @@ CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
 CONFIG_I2C_CADENCE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_DIGICOLOR=y
 CONFIG_I2C_GPIO=m
 CONFIG_I2C_EXYNOS5=y
 CONFIG_I2C_MV64XXX=y
@@ -504,6 +508,7 @@ CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_S35390A=m
 CONFIG_RTC_DRV_EM3027=y
+CONFIG_RTC_DRV_DIGICOLOR=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_VT8500=y
 CONFIG_RTC_DRV_SUN6I=y
-- 
2.1.4
