From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 10 Mar 2013 10:29:21 +0800
Subject: [PATCH] ARM:vexpress: beautify code, using 'static const' instead
 of 'const static'
Message-ID: <513BF001.30204@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  better using 'static const' instead of 'const static'

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-vexpress/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index dc1ace5..9152bf7 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -40,7 +40,7 @@ static struct map_desc vexpress_dt_cortex_a9_scu_map __initdata = {
 
 static void *vexpress_dt_cortex_a9_scu_base __initdata;
 
-const static char *vexpress_dt_cortex_a9_match[] __initconst = {
+static const char *vexpress_dt_cortex_a9_match[] __initconst = {
 	"arm,cortex-a5-scu",
 	"arm,cortex-a9-scu",
 	NULL
-- 
1.7.7.6
