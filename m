From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed,  5 Feb 2014 17:04:13 +0000
Subject: [PATCH 22/22] arm: update boot/compressed/.gitignore
In-Reply-To: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1391619853-10601-23-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bswapsdi2.S, fdt_empty_tree.c and fdt_sw.c to ignore list.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 arch/arm/boot/compressed/.gitignore |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index 47279aa..cc3487e 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,4 +1,5 @@
 ashldi3.S
+bswapsdi2.S
 font.c
 lib1funcs.S
 hyp-stub.S
@@ -13,8 +14,10 @@ vmlinux.lds
 # borrowed libfdt files
 fdt.c
 fdt.h
+fdt_empty_tree.c
 fdt_ro.c
 fdt_rw.c
+fdt_sw.c
 fdt_wip.c
 libfdt.h
 libfdt_internal.h
-- 
1.7.10.4
