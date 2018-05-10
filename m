From: colin.king@canonical.com (Colin King)
Date: Thu, 10 May 2018 17:02:39 +0100
Subject: [PATCH] ARM: kprobes: fix spelling mistake: "undefeined" ->
 "undefined"
Message-ID: <20180510160239.21091-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/probes/kprobes/test-thumb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
index b683b4517458..6841909757cd 100644
--- a/arch/arm/probes/kprobes/test-thumb.c
+++ b/arch/arm/probes/kprobes/test-thumb.c
@@ -787,7 +787,7 @@ CONDITION_INSTRUCTIONS(22,
 
 	TEST_UNSUPPORTED(__inst_thumb32(0xf7f08000) " @ smc #0")
 
-	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefeined")
+	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefined")
 
 	TEST_BF(  "b.w	2f")
 	TEST_BB(  "b.w	2b")
-- 
2.17.0
