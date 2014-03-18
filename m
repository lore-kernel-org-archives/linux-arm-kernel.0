From: brezillonboris@gmail.com (Boris BREZILLON)
Date: Tue, 18 Mar 2014 21:18:40 +0100
Subject: [PATCH 07/11] ARM: at91/dt: add xtal frequencies to sama5d3 xplained
 board
In-Reply-To: <1395173924-3648-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1395173924-3648-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1395173924-3648-8-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define crystal properties of sama5d3 xplained board.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index ce13755..df5b707 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -21,6 +21,16 @@
 		reg = <0x20000000 0x10000000>;
 	};
 
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
 	ahb {
 		apb {
 			mmc0: mmc at f0000000 {
-- 
1.7.9.5
