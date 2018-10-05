From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 5 Oct 2018 15:31:40 +0530
Subject: [PATCH] arm64: defconfig: Enable SERIAL_8250_OMAP
Message-ID: <20181005100140.16716-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling CONFIG_SERIAL_8250_OMAP that is used by TI's
AM6 SoC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
- Based on next tag: next-20181005

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 030186c180aa..0baf31ca069f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -288,6 +288,7 @@ CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_BCM2835AUX=y
 CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_8250_UNIPHIER=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.19.0
