From: standby24x7@gmail.com (Masanari Iida)
Date: Sun, 24 Jan 2016 15:24:12 +0900
Subject: [PATCH] arm64: Fix typo mm/dump.c
Message-ID: <1453616652-8430-1-git-send-email-standby24x7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix a typo in mm/dump.c
"MODUELS_END_NR" should be "MODULES_END_NR".

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/arm64/mm/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 5a22a11..0adbebb 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -46,7 +46,7 @@ enum address_markers_idx {
 	PCI_START_NR,
 	PCI_END_NR,
 	MODULES_START_NR,
-	MODUELS_END_NR,
+	MODULES_END_NR,
 	KERNEL_SPACE_NR,
 };
 
-- 
2.7.0
