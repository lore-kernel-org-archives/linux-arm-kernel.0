From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 1 Dec 2017 17:36:50 +0100
Subject: [PATCH  1/2] serial: stm32: add default console
In-Reply-To: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
References: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1512146211-29086-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds by default the console support
on stm32.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b788fee..969e598 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1664,6 +1664,7 @@ config SERIAL_STM32_CONSOLE
 	bool "Support for console on STM32"
 	depends on SERIAL_STM32=y
 	select SERIAL_CORE_CONSOLE
+	default y
 
 config SERIAL_MVEBU_UART
 	bool "Marvell EBU serial port support"
-- 
2.7.4
