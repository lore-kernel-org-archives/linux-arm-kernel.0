From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Tue, 13 Oct 2015 13:12:09 +0200
Subject: [PATCH] ARM: dts: berlin: fix typo in chosen property
Message-ID: <1444734729-4818-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a trivial typo in the name of the "chosen" device tree property
for the Marvell BG2-Q DMP board.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 4a749e5b3b44..caeeb345c335 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -48,7 +48,7 @@
 		reg = <0x00000000 0x80000000>;
 	};
 
-	choosen {
+	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
-- 
2.1.4
