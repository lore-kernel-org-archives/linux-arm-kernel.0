From: vincent.stehle@freescale.com (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Wed, 3 Jul 2013 10:12:58 +0200
Subject: [PATCH linux-next 1/2] arm: multi_v7_defconfig: add i.MX serial
 console
In-Reply-To: <1372839179-14542-1-git-send-email-vincent.stehle@freescale.com>
References: <1372839179-14542-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <1372839179-14542-2-git-send-email-vincent.stehle@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX serial console support. This gives us the boot messages on UART on
e.g. the i.MX6Q sabre sd platform.

Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d8d3c4..cc8723a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -75,6 +75,8 @@ CONFIG_SERIAL_OMAP=y
 CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
-- 
1.7.10.4
