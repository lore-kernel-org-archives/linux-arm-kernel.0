From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 20 Oct 2016 09:52:11 +0900
Subject: [PATCH] ARM: dts: berlin2q-marvell-dmp: fix typo in chosen node
Message-ID: <1476924731-14975-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index f485308..d57d675 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -48,7 +48,7 @@
 		reg = <0x00000000 0x80000000>;
 	};
 
-	choosen {
+	chosen {
 		bootargs = "earlyprintk";
 		stdout-path = "serial0:115200n8";
 	};
-- 
1.9.1
