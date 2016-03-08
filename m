From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Tue, 8 Mar 2016 10:20:15 +0800
Subject: [PATCH v10 3/6] ARM: hisi: add compatible string for Hi3519 soc
In-Reply-To: <1457403618-18317-1-git-send-email-xuejiancheng@huawei.com>
References: <1457403618-18317-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1457403618-18317-4-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add compatible string for Hi3519 soc.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/mach-hisi/hisilicon.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 8cc6215..00dae89 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -54,30 +54,15 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.dt_compat	= hi3xxx_compat,
 MACHINE_END
 
-static const char *const hix5hd2_compat[] __initconst = {
+static const char *const hisilicon_compat[] __initconst = {
 	"hisilicon,hix5hd2",
-	NULL,
-};
-
-DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
-	.dt_compat	= hix5hd2_compat,
-MACHINE_END
-
-static const char *const hip04_compat[] __initconst = {
 	"hisilicon,hip04-d01",
-	NULL,
-};
-
-DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
-	.dt_compat	= hip04_compat,
-MACHINE_END
-
-static const char *const hip01_compat[] __initconst = {
 	"hisilicon,hip01",
 	"hisilicon,hip01-ca9x2",
+	"hisilicon,hi3519",
 	NULL,
 };
 
-DT_MACHINE_START(HIP01, "Hisilicon HIP01 (Flattened Device Tree)")
-	.dt_compat      = hip01_compat,
+DT_MACHINE_START(HISILICON_DT, "HiSilicon Soc")
+	.dt_compat	= hisilicon_compat,
 MACHINE_END
-- 
1.9.1
