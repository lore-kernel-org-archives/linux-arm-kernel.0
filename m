From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Oct 2012 11:17:20 +0800
Subject: ARM_ATAG_DTB_COMPAT fails on fdt_ro.c compiling
Message-ID: <20121009031715.GC21822@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have seen this error on mainline for a couple days when
ARM_ATAG_DTB_COMPAT is enabled.

  CC      arch/arm/boot/compressed/fdt_ro.o
arch/arm/boot/compressed/fdt_ro.c: In function ?fdt_path_offset?:
arch/arm/boot/compressed/fdt_ro.c:172:3: error: implicit declaration of function ?fdt_get_alias_namelen? [-Werror=implicit-function-declaration]
arch/arm/boot/compressed/fdt_ro.c:172:5: warning: assignment makes pointer from integer without a cast [enabled by default]
arch/arm/boot/compressed/fdt_ro.c: At top level:
arch/arm/boot/compressed/fdt_ro.c:340:13: error: conflicting types for ?fdt_get_alias_namelen?
arch/arm/boot/compressed/fdt_ro.c:172:7: note: previous implicit declaration of ?fdt_get_alias_namelen? was here
cc1: some warnings being treated as errors

Shawn
