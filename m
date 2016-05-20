From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 12:07:26 -0700
Subject: [PATCH 1/7] ARM: multi_v7_defconfig: Enable BCM63xx
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1463771252-12805-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_BCM_63XX to build ARM-specific boot and SMP code, as well as
the serial console driver for this platform.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f857564657f..968a7ec08633 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -36,6 +36,7 @@ CONFIG_ARCH_BCM_21664=y
 CONFIG_ARCH_BCM_281XX=y
 CONFIG_ARCH_BCM_5301X=y
 CONFIG_ARCH_BCM2835=y
+CONFIG_ARCH_BCM_63XX=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_MACH_BERLIN_BG2=y
@@ -291,6 +292,8 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_SERIAL_ATMEL_TTYAT=y
+CONFIG_SERIAL_BCM63XX=y
+CONFIG_SERIAL_BCM63XX_CONSOLE=y
 CONFIG_SERIAL_MESON=y
 CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
-- 
2.7.4
