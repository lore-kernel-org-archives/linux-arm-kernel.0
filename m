From: will.deacon@arm.com (Will Deacon)
Date: Wed,  5 Sep 2018 15:12:27 +0100
Subject: [PATCH] arm64: dump: Use consistent capitalisation for page-table
 dumps
Message-ID: <1536156747-29900-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Being consistent in our capitalisation for page-table dumps helps when
grepping for things like "end".

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 65dfc8571bf8..fcb1f2a6d7c6 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -36,8 +36,8 @@ static const struct addr_marker address_markers[] = {
 #endif
 	{ MODULES_VADDR,		"Modules start" },
 	{ MODULES_END,			"Modules end" },
-	{ VMALLOC_START,		"vmalloc() Area" },
-	{ VMALLOC_END,			"vmalloc() End" },
+	{ VMALLOC_START,		"vmalloc() area" },
+	{ VMALLOC_END,			"vmalloc() end" },
 	{ FIXADDR_START,		"Fixmap start" },
 	{ FIXADDR_TOP,			"Fixmap end" },
 	{ PCI_IO_START,			"PCI I/O start" },
@@ -46,7 +46,7 @@ static const struct addr_marker address_markers[] = {
 	{ VMEMMAP_START,		"vmemmap start" },
 	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
 #endif
-	{ PAGE_OFFSET,			"Linear Mapping" },
+	{ PAGE_OFFSET,			"Linear mapping" },
 	{ -1,				NULL },
 };
 
-- 
2.1.4
