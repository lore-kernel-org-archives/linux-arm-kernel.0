From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  7 Oct 2015 09:26:39 -0600
Subject: [PATCH 2/6] coresight: fixing typographical error
In-Reply-To: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
References: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1444231603-26676-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tracing gets enabled _for_ a source rather than _from_ a source.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/coresight.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c69e1b932809..a7cabfa23b55 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -207,7 +207,7 @@ struct coresight_ops_link {
  * Operations available for sources.
  * @trace_id:	returns the value of the component's trace ID as known
 		to the HW.
- * @enable:	enables tracing from a source.
+ * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
  */
 struct coresight_ops_source {
-- 
1.9.1
