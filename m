From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 27 May 2014 16:58:27 +0530
Subject: [PATCH 1/1] ARM: mvebu: Staticize mvebu_cpu_reset_init
Message-ID: <1401190107-21359-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'mvebu_cpu_reset_init' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-mvebu/cpu-reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index 4a8f9eebebea..60fb53787004 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -67,7 +67,7 @@ static int mvebu_cpu_reset_map(struct device_node *np, int res_idx)
 	return 0;
 }
 
-int __init mvebu_cpu_reset_init(void)
+static int __init mvebu_cpu_reset_init(void)
 {
 	struct device_node *np;
 	int res_idx;
-- 
1.7.9.5
