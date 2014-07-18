From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Jul 2014 02:19:54 +0200
Subject: [PATCH v2 2/7] ARM: rockchip: clarify usability of DEBUG_RK3X_UART
 debug_ll options
In-Reply-To: <4868343.UFgjaXesOn@diego>
References: <4868343.UFgjaXesOn@diego>
Message-ID: <1722917.h37akzFaqW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug uart settings from the DEBUG_RK3X_UART options are usable on
all Rockchip SoCs from the rk30xx and rk31xx series but not on the
new rk3288 SoCs. Thus clarify their use to prevent confusion.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..a8dbf5e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -582,7 +582,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART0
-		bool "Kernel low-level debugging messages via Rockchip RK3X UART0"
+		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -590,7 +590,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART1
-		bool "Kernel low-level debugging messages via Rockchip RK3X UART1"
+		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -598,7 +598,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK3X UART2"
+		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -606,7 +606,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART3
-		bool "Kernel low-level debugging messages via Rockchip RK3X UART3"
+		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART3"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
-- 
1.9.0
