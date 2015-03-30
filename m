From: maninder1.s@samsung.com (Maninder Singh)
Date: Mon, 30 Mar 2015 11:16:04 +0000 (GMT)
Subject: [ARM: code clean up local_irq_disable]
Message-ID: <1161463623.92611427714164373.JavaMail.weblogic@epmlwas01c>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Subject: [PATCH] ARM: code clean up local_irq_disable

Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 arch/arm/kernel/process.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..18cfce4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -195,7 +195,6 @@ void machine_halt(void)
  local_irq_disable();
  smp_send_stop();
 
- local_irq_disable();
  while (1);
 }
 
-- 
1.7.1

Thanks and Regards,
Maninder Singh
