From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:32:09 +0100
Subject: [PATCH 10/11] ARM: at91/dt: declare matrix node as a syscon device
In-Reply-To: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417606330-17753-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 7119f1f..e52ae97 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -257,7 +257,7 @@
 			};
 
 			matrix: matrix at ffffee00 {
-				compatible = "atmel,at91sam9260-bus-matrix";
+				compatible = "atmel,at91sam9260-bus-matrix", "syscon";
 				reg = <0xffffee00 0x200>;
 			};
 
-- 
1.9.1
