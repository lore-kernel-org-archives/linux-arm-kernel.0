From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 17 Apr 2018 10:08:05 -0600
Subject: [PATCH v2 1/3] coresight: Remove obsolete reference to "owner" in
 CoreSight descriptor
In-Reply-To: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1523981287-15370-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Field "owner" of struct coresight_desc has been removed a while back but
the documentation was not updated to reflect the changes.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 6f0120c3a4f1..710c75b6c73f 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -187,9 +187,6 @@ that can be performed on them (see "struct coresight_ops").  The
 specific to that component only.  "Implementation defined" customisations are
 expected to be accessed and controlled using those entries.
 
-Last but not least, "struct module *owner" is expected to be set to reflect
-the information carried in "THIS_MODULE".
-
 How to use the tracer modules
 -----------------------------
 
-- 
2.7.4
