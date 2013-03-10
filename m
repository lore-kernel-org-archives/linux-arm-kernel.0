From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 10 Mar 2013 09:59:22 +0800
Subject: [PATCH] ARM:kernel: beautify code, using 'static const' instead of
 'const static'
Message-ID: <513BE8FA.6080304@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  better using 'static const' instead of 'const static'

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 3f25650..ef3e499 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -362,7 +362,7 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
 }
 
 #ifdef CONFIG_OF
-const static struct of_device_id twd_of_match[] __initconst = {
+static const struct of_device_id twd_of_match[] __initconst = {
 	{ .compatible = "arm,cortex-a9-twd-timer",	},
 	{ .compatible = "arm,cortex-a5-twd-timer",	},
 	{ .compatible = "arm,arm11mp-twd-timer",	},
-- 
1.7.7.6
