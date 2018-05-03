From: leo.yan@linaro.org (Leo Yan)
Date: Thu,  3 May 2018 23:18:23 +0800
Subject: [PATCH 2/2] perf cs-etm: Remove redundant space
In-Reply-To: <1525360703-26159-1-git-send-email-leo.yan@linaro.org>
References: <1525360703-26159-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1525360703-26159-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There have two spaces ahead function name cs_etm__set_pid_tid_cpu(), so
remove one space and correct indentation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 417302c..3137fbe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -612,8 +612,8 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	return buff->len;
 }
 
-static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				     struct auxtrace_queue *queue)
+static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
+				    struct auxtrace_queue *queue)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
-- 
2.7.4
