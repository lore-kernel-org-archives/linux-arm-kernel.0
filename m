From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Sat, 6 Oct 2018 15:57:38 +0800
Subject: [PATCH] arm64: perf: Fix typos in comment
Message-ID: <1538812658-9290-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix up one typos: Onl -> Only

Cc: Will Deacon <will.deacon@arm.com> 
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 8e38d52..316e74b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1003,7 +1003,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	if (armv8pmu_event_is_64bit(event))
 		event->hw.flags |= ARMPMU_EVT_64BIT;
 
-	/* Onl expose micro/arch events supported by this PMU */
+	/* Only expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
 		return hw_event_id;
-- 
2.7.4
