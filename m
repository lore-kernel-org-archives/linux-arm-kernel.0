From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 31 Mar 2017 02:44:17 +0900
Subject: [PATCH] arm64: drop non-existing vdso-offsets.h from .gitignore
Message-ID: <1490895857-26856-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit a66649dab350 ("arm64: fix vdso-offsets.h dependency"),
include/generated/vdso-offsets.h is directly generated without
arch/arm64/kernel/vdso/vdso-offsets.h.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/kernel/vdso/.gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/.gitignore b/arch/arm64/kernel/vdso/.gitignore
index b8cc94e..f8b69d8 100644
--- a/arch/arm64/kernel/vdso/.gitignore
+++ b/arch/arm64/kernel/vdso/.gitignore
@@ -1,2 +1 @@
 vdso.lds
-vdso-offsets.h
-- 
2.7.4
