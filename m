From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 May 2013 14:46:57 +0400
Subject: [PATCH 1/3] ARM: dts: Add aliases for i.MX27 SPI controller
Message-ID: <1367405219-19078-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add aliases to determine the proper SPI bus number.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index ff4bd48..cd85828 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -25,6 +25,9 @@
 		gpio3 = &gpio4;
 		gpio4 = &gpio5;
 		gpio5 = &gpio6;
+		spi0 = &cspi1;
+		spi1 = &cspi2;
+		spi2 = &cspi3;
 	};
 
 	avic: avic-interrupt-controller at e0000000 {
-- 
1.8.1.5
