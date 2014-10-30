From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Thu, 30 Oct 2014 16:51:17 +0100
Subject: [PATCH] ARM: dts: rockchip: add serial aliases for rk3066 and rk3188
Message-ID: <1414684277-17248-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add aliases for UARTs on rk3066 and rk3188 in order to fix the numbering scheme.
This will keep the debug console on ttyS2 when UART 1 is disabled, for example.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 499468d..d8027c4 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -29,6 +29,10 @@
 		mshc0 = &emmc;
 		mshc1 = &mmc0;
 		mshc2 = &mmc1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 		spi0 = &spi0;
 		spi1 = &spi1;
 	};
-- 
2.1.0
