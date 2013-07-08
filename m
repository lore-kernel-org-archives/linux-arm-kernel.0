From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Jul 2013 15:20:05 +0900
Subject: [PATCH] ARM: shmobile: Fix EMEV2 clock comment typo
Message-ID: <20130708062005.25694.62165.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the STI timer frequency comment to 32.768 kHz to
fix 37 kHz typo.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "renesas-next-20130704v2"

 arch/arm/mach-shmobile/clock-emev2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-emev2.c
+++ work/arch/arm/mach-shmobile/clock-emev2.c	2013-07-08 15:05:16.000000000 +0900
@@ -203,7 +203,7 @@ void __init emev2_clock_init(void)
 	smu_base = ioremap(EMEV2_SMU_BASE, PAGE_SIZE);
 	BUG_ON(!smu_base);
 
-	/* setup STI timer to run on 37.768 kHz and deassert reset */
+	/* setup STI timer to run on 32.768 kHz and deassert reset */
 	emev2_smu_write(0, STI_CLKSEL);
 	emev2_smu_write(1, STI_RSTCTRL);
 
