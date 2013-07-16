From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:44:13 +0100
Subject: [PATCH RFC v2 11/14] ARM: debug: remove DEBUG_ROCKCHIP_UART
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8MH-000489-44@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ecb3b32..605bfa8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -492,7 +492,6 @@ choice
 	config DEBUG_RK29_UART0
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -501,7 +500,6 @@ choice
 	config DEBUG_RK29_UART1
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART1"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -510,7 +508,6 @@ choice
 	config DEBUG_RK29_UART2
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART2"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -519,7 +516,6 @@ choice
 	config DEBUG_RK3X_UART0
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART0"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -528,7 +524,6 @@ choice
 	config DEBUG_RK3X_UART1
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART1"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -537,7 +532,6 @@ choice
 	config DEBUG_RK3X_UART2
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART2"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -546,7 +540,6 @@ choice
 	config DEBUG_RK3X_UART3
 		bool "Kernel low-level debugging messages via Rockchip RK3X UART3"
 		depends on ARCH_ROCKCHIP
-		select DEBUG_ROCKCHIP_UART
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -857,10 +850,6 @@ config DEBUG_IMX_UART_PORT
 	  Choose UART port on which kernel low-level debug messages
 	  should be output.
 
-config DEBUG_ROCKCHIP_UART
-	bool
-	depends on ARCH_ROCKCHIP
-
 config DEBUG_TEGRA_UART
 	bool
 	depends on ARCH_TEGRA
-- 
1.7.4.4
