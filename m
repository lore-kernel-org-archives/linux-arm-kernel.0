From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:36 -0400
Subject: [PATCH 51/52] ARM: mach-w90x900: remove useless boot_params entries
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-51-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-w90x900/mach-nuc910evb.c |    1 -
 arch/arm/mach-w90x900/mach-nuc950evb.c |    1 -
 arch/arm/mach-w90x900/mach-nuc960evb.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-w90x900/mach-nuc910evb.c b/arch/arm/mach-w90x900/mach-nuc910evb.c
index 30fccde..31c1090 100644
--- a/arch/arm/mach-w90x900/mach-nuc910evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc910evb.c
@@ -34,7 +34,6 @@ static void __init nuc910evb_init(void)
 
 MACHINE_START(W90P910EVB, "W90P910EVB")
 	/* Maintainer: Wan ZongShun */
-	.boot_params	= 0,
 	.map_io		= nuc910evb_map_io,
 	.init_irq	= nuc900_init_irq,
 	.init_machine	= nuc910evb_init,
diff --git a/arch/arm/mach-w90x900/mach-nuc950evb.c b/arch/arm/mach-w90x900/mach-nuc950evb.c
index 590c99b..4062e55 100644
--- a/arch/arm/mach-w90x900/mach-nuc950evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc950evb.c
@@ -37,7 +37,6 @@ static void __init nuc950evb_init(void)
 
 MACHINE_START(W90P950EVB, "W90P950EVB")
 	/* Maintainer: Wan ZongShun */
-	.boot_params	= 0,
 	.map_io		= nuc950evb_map_io,
 	.init_irq	= nuc900_init_irq,
 	.init_machine	= nuc950evb_init,
diff --git a/arch/arm/mach-w90x900/mach-nuc960evb.c b/arch/arm/mach-w90x900/mach-nuc960evb.c
index e09c645..0ab9995 100644
--- a/arch/arm/mach-w90x900/mach-nuc960evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc960evb.c
@@ -34,7 +34,6 @@ static void __init nuc960evb_init(void)
 
 MACHINE_START(W90N960EVB, "W90N960EVB")
 	/* Maintainer: Wan ZongShun */
-	.boot_params	= 0,
 	.map_io		= nuc960evb_map_io,
 	.init_irq	= nuc900_init_irq,
 	.init_machine	= nuc960evb_init,
-- 
1.7.4
