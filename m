From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 30 May 2014 16:07:36 +0530
Subject: [PATCH Resend 3/8] ARM: mvebu: Staticize armada_370_xp_cpu_pm_init
In-Reply-To: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
References: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401446261-22423-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'armada_370_xp_cpu_pm_init' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/pmsu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8520bf..861f6be7a26c 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -263,7 +263,7 @@ static struct notifier_block armada_370_xp_cpu_pm_notifier = {
 	.notifier_call = armada_370_xp_cpu_pm_notify,
 };
 
-int __init armada_370_xp_cpu_pm_init(void)
+static int __init armada_370_xp_cpu_pm_init(void)
 {
 	struct device_node *np;
 
-- 
1.7.9.5
