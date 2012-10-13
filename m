From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Sat, 13 Oct 2012 13:55:58 +0530
Subject: [PATCH 1/1] ARM64: Remove duplicate inclusion of mmu_context.h in
 smp.c
Message-ID: <1350116758-624-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/mmu_context.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm64/kernel/smp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b711525..226b6bf 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -46,7 +46,6 @@
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
-#include <asm/mmu_context.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
-- 
1.7.4.1
