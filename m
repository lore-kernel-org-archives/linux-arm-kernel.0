From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 30 May 2014 16:07:35 +0530
Subject: [PATCH Resend 2/8] ARM: mvebu: Staticize armada_375_smp_cpu1_enable_wa
In-Reply-To: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
References: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401446261-22423-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'armada_375_smp_cpu1_enable_wa' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/platsmp-a9.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 96c2c59e34b6..abe02b15c9a3 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -33,7 +33,7 @@
 extern unsigned char armada_375_smp_cpu1_enable_code_end;
 extern unsigned char armada_375_smp_cpu1_enable_code_start;
 
-void armada_375_smp_cpu1_enable_wa(void)
+static void armada_375_smp_cpu1_enable_wa(void)
 {
 	void __iomem *sram_virt_base;
 
-- 
1.7.9.5
