From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:41:19 +0100
Subject: [PATCH 8/8] ARM: sirf: enable support in multi_v7_defconfig
In-Reply-To: <1363779679-16880-1-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
Message-ID: <1363779679-16880-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables all sirf specific drivers in the defconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e31d442..44ec305 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
+CONFIG_ARCH_SIRF=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_SOCFPGA=y
@@ -34,12 +35,16 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_SIRFSOC=y
+CONFIG_SERIAL_SIRFSOC_CONSOLE=y
 CONFIG_IPMI_HANDLER=y
 CONFIG_IPMI_SI=y
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_SIRF=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
+CONFIG_SPI_SIRF=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -58,3 +63,4 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
+CONFIG_SIRF_DMA=y
-- 
1.8.1.2
