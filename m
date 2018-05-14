From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Mon, 14 May 2018 09:23:20 -0300
Subject: [PATCH 4/5] perf cs-etm: Remove redundant space
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
References: <20180514122321.27304-1-acme@kernel.org>
Message-ID: <20180514122321.27304-5-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

There have two spaces ahead function name cs_etm__set_pid_tid_cpu(), so
remove one space and correct indentation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1525924920-4381-2-git-send-email-leo.yan at linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2bf28b5acc08..bf16dc9ee507 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -613,8 +613,8 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	return buff->len;
 }
 
-static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				     struct auxtrace_queue *queue)
+static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
+				    struct auxtrace_queue *queue)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
-- 
2.14.3
