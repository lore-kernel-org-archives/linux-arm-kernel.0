From: stefan@agner.ch (Stefan Agner)
Date: Mon, 27 Aug 2018 22:05:05 +0200
Subject: [PATCH] ARM: wire up io_pgetevents syscall
Message-ID: <20180827200505.21991-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire up the new io_pgetevents syscall for ARM.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/tools/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index fbc74b5fa3ed..8edf93b4490f 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -413,3 +413,4 @@
 396	common	pkey_free		sys_pkey_free
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
+399	common	io_pgetevents		sys_io_pgetevents
-- 
2.18.0
