From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 22 Jul 2014 16:14:42 +0100
Subject: [PATCH] Documentation/arm64/memory.txt: fix typo
Message-ID: <1406042082-1519-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no swapper_pgd_dir, it meant swapper_pg_dir.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 Documentation/arm64/memory.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
index d50fa61..dd724c8 100644
--- a/Documentation/arm64/memory.txt
+++ b/Documentation/arm64/memory.txt
@@ -17,7 +17,7 @@ User addresses have bits 63:39 set to 0 while the kernel addresses have
 the same bits set to 1. TTBRx selection is given by bit 63 of the
 virtual address. The swapper_pg_dir contains only kernel (global)
 mappings while the user pgd contains only user (non-global) mappings.
-The swapper_pgd_dir address is written to TTBR1 and never written to
+The swapper_pg_dir address is written to TTBR1 and never written to
 TTBR0.
 
 
-- 
2.0.2
