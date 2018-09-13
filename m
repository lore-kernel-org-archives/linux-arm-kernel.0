From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 15:28:27 -0500
Subject: [PATCH 2/3] scripts/dtc: Add yamltree.c to dtc sources
In-Reply-To: <20180913202828.15372-1-robh@kernel.org>
References: <20180913202828.15372-1-robh@kernel.org>
Message-ID: <20180913202828.15372-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has a new source file, yamltree.c, that needs to be copied when
syncing dtc sources.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/dtc/update-dtc-source.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index 1a009fd195d0..7dd29a0362b8 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
 DTC_LINUX_PATH=`pwd`/scripts/dtc
 
 DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
-		srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
+		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c Makefile.dtc \
 		dtc-lexer.l dtc-parser.y"
 LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
-- 
2.17.1
