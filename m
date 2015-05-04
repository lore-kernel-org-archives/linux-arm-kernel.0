From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  4 May 2015 14:27:04 +0200
Subject: [PATCH v2 5/7] ARM: marvell/dt: add crypto node to armada-xp-gp board
In-Reply-To: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1430742426-21202-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 206aebb..586b60b 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -94,7 +94,9 @@
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
-			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
+			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
 		devbus-bootcs {
 			status = "okay";
-- 
1.9.1
