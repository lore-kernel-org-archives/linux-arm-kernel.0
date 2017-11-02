From: colin.king@canonical.com (Colin King)
Date: Thu,  2 Nov 2017 09:27:37 +0000
Subject: [PATCH] ARM: meson: fix spelling mistake: "Couln't" -> "Couldn't"
Message-ID: <20171102092737.16957-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-meson/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/platsmp.c b/arch/arm/mach-meson/platsmp.c
index 2555f9056a33..cad7ee8f0d6b 100644
--- a/arch/arm/mach-meson/platsmp.c
+++ b/arch/arm/mach-meson/platsmp.c
@@ -102,7 +102,7 @@ static void __init meson_smp_prepare_cpus(const char *scu_compatible,
 
 	scu_base = of_iomap(node, 0);
 	if (!scu_base) {
-		pr_err("Couln't map SCU registers\n");
+		pr_err("Couldn't map SCU registers\n");
 		return;
 	}
 
-- 
2.14.1
