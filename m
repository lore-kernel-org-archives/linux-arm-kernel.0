From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 2 Nov 2011 19:03:54 +0800
Subject: [PATCH] slub: doc: update the slabinfo.c file path
In-Reply-To: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
References: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1320231836-9555-4-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

slabinfo.c has been moved from Documentaion/vm/ to
tools/slub/ by commit:0d24db337e6d81c0c620ab65cc6947bd6553f742

Update the slub.txt doc to reflect this change too.

Signed-off-by: Jason Liu <jason.hui@linaro.org>
Cc: Christoph Lameter <cl@linux-foundation.org>
---
 Documentation/vm/00-INDEX |    2 --
 Documentation/vm/slub.txt |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/00-INDEX b/Documentation/vm/00-INDEX
index dca82d7..5481c8b 100644
--- a/Documentation/vm/00-INDEX
+++ b/Documentation/vm/00-INDEX
@@ -30,8 +30,6 @@ page_migration
 	- description of page migration in NUMA systems.
 pagemap.txt
 	- pagemap, from the userspace perspective
-slabinfo.c
-	- source code for a tool to get reports about slabs.
 slub.txt
 	- a short users guide for SLUB.
 unevictable-lru.txt
diff --git a/Documentation/vm/slub.txt b/Documentation/vm/slub.txt
index 07375e7..f464f47 100644
--- a/Documentation/vm/slub.txt
+++ b/Documentation/vm/slub.txt
@@ -17,7 +17,7 @@ data and perform operation on the slabs. By default slabinfo only lists
 slabs that have data in them. See "slabinfo -h" for more options when
 running the command. slabinfo can be compiled with
 
-gcc -o slabinfo Documentation/vm/slabinfo.c
+gcc -o slabinfo tools/slub/slabinfo.c
 
 Some of the modes of operation of slabinfo require that slub debugging
 be enabled on the command line. F.e. no tracking information will be
-- 
1.7.4.1
