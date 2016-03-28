From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Mon, 28 Mar 2016 10:38:31 +0200
Subject: [PATCH 1/1] ARM: dts: kirkwood: add kirkwood-nsa320.dtb to Makefile
Message-ID: <1459154311-4770-1-git-send-email-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit be3d7d023b87 ("ARM: kirkwood: Add DTS file for NSA320")
created the new file kirkwood-nsa320.dts but did not
add it to the Makefile.

Fixes: be3d7d023b87 ("ARM: kirkwood: Add DTS file for NSA320")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f8308db..e75a340 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -215,6 +215,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ns2mini.dtb \
 	kirkwood-nsa310.dtb \
 	kirkwood-nsa310a.dtb \
+	kirkwood-nsa320.dtb \
 	kirkwood-nsa325.dtb \
 	kirkwood-openblocks_a6.dtb \
 	kirkwood-openblocks_a7.dtb \
-- 
2.1.4
