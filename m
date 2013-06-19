From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Jun 2013 10:53:03 -0700
Subject: [PATCH RFC 1/2] arm: multi_v7_defconfig: Enable Zynq UART driver
In-Reply-To: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1371664384-24974-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2e67a27..d5f0d76 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -42,6 +42,8 @@ CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_XILINX_PS_UART=y
+CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_SIRFSOC=y
 CONFIG_SERIAL_SIRFSOC_CONSOLE=y
 CONFIG_SERIAL_VT8500=y
-- 
1.8.3.1
