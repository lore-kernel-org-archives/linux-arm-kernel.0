From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 22 Apr 2014 15:12:36 +0200
Subject: [PATCH v3 07/11] ARM: at91/dt: add xtal frequencies to sama5d3
 xplained board
In-Reply-To: <1398172360-7837-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1398172360-7837-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1398172360-7837-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define crystal properties of sama5d3 xplained board.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index ce13755..f1a1119 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -21,6 +21,14 @@
 		reg = <0x20000000 0x10000000>;
 	};
 
+	slow_xtal {
+		clock-frequency = <32768>;
+	};
+
+	main_xtal {
+		clock-frequency = <12000000>;
+	};
+
 	ahb {
 		apb {
 			mmc0: mmc at f0000000 {
-- 
1.8.3.2
