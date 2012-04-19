From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 19 Apr 2012 13:11:39 -0700
Subject: [PATCH] arm: omap3: Remove superfluous commas from
 gfx_sgx_3xxx_wkdeps[]
Message-ID: <1334866299-8198-1-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Clean up clockdomains3xxx_data.c a bit by removing the
superfluous commas in gfx_sgx_3xxx_wkdeps[].

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index b84e138..6038adb 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -53,9 +53,9 @@
  * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
  */
 static struct clkdm_dep gfx_sgx_3xxx_wkdeps[] = {
-	{ .clkdm_name = "iva2_clkdm", },
-	{ .clkdm_name = "mpu_clkdm", },
-	{ .clkdm_name = "wkup_clkdm", },
+	{ .clkdm_name = "iva2_clkdm" },
+	{ .clkdm_name = "mpu_clkdm" },
+	{ .clkdm_name = "wkup_clkdm" },
 	{ NULL },
 };
 
-- 
1.7.9.4
