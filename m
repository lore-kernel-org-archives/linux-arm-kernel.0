From: viniciustinti@gmail.com (Vinicius Tinti)
Date: Fri,  1 Mar 2013 01:25:52 -0300
Subject: [PATCH 1/1] arm: remove extra semicolon in if statement
Message-ID: <1362111952-8072-1-git-send-email-viniciustinti@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove extra semicolon in perf_event.c if statement.

Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
---
 arch/arm/kernel/perf_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 31e0eb3..a892067 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -400,7 +400,7 @@ __hw_perf_event_init(struct perf_event *event)
 	}
 
 	if (event->group_leader != event) {
-		if (validate_group(event) != 0);
+		if (validate_group(event) != 0)
 			return -EINVAL;
 	}
 
-- 
1.7.9.5
