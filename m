From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon,  9 Jul 2012 11:27:06 +0200
Subject: [PATCH v4 5/5] sched: cpu_power: enable ARCH_POWER
In-Reply-To: <1341826026-6504-1-git-send-email-vincent.guittot@linaro.org>
References: <1341826026-6504-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1341826026-6504-6-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heteregeneous ARM platform uses arch_scale_freq_power function
to reflect the relative capacity of each core

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/features.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index de00a48..d98ae90 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -42,7 +42,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
 /*
  * Use arch dependent cpu power functions
  */
-SCHED_FEAT(ARCH_POWER, false)
+SCHED_FEAT(ARCH_POWER, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(DOUBLE_TICK, false)
-- 
1.7.9.5
