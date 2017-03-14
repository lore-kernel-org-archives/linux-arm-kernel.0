From: code@mmayer.net (Markus Mayer)
Date: Tue, 14 Mar 2017 11:55:23 -0700
Subject: [PATCH] ARM: wire up new statx syscall
Message-ID: <20170314185523.38598-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

Add new statx syscall to ARM syscall table.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

It looks like this hasn't been submitted before, so here goes.

 arch/arm/tools/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 3c2cb5d..0bb0e9c 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -411,3 +411,4 @@
 394	common	pkey_mprotect		sys_pkey_mprotect
 395	common	pkey_alloc		sys_pkey_alloc
 396	common	pkey_free		sys_pkey_free
+397	common	statx			sys_statx
-- 
2.7.4
