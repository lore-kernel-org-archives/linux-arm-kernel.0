From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 14:13:37 -0600
Subject: [PATCH 4/8] coresight: Correcting documentation typographical error
In-Reply-To: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
References: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1427746421-31360-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 02361552a3ea..77d14d51a670 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -14,7 +14,7 @@ document is concerned with the latter.
 HW assisted tracing is becoming increasingly useful when dealing with systems
 that have many SoCs and other components like GPU and DMA engines.  ARM has
 developed a HW assisted tracing solution by means of different components, each
-being added to a design at systhesis time to cater to specific tracing needs.
+being added to a design at synthesis time to cater to specific tracing needs.
 Compoments are generally categorised as source, link and sinks and are
 (usually) discovered using the AMBA bus.
 
-- 
1.9.1
