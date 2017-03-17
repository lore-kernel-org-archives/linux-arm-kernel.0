From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 17 Mar 2017 22:42:04 +1300
Subject: [PATCH] ARM: wire up statx syscall
Message-ID: <20170317094204.15630-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/tools/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 3c2cb5d5adfa..0bb0e9c6376c 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -411,3 +411,4 @@
 394	common	pkey_mprotect		sys_pkey_mprotect
 395	common	pkey_alloc		sys_pkey_alloc
 396	common	pkey_free		sys_pkey_free
+397	common	statx			sys_statx
-- 
2.11.0.24.ge6920cf
