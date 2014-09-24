From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Sep 2014 22:49:01 +0800
Subject: [PATCH v2 7/7] Documentation: sunxi: Add A80 datasheet link
In-Reply-To: <1411570141-29960-1-git-send-email-wens@csie.org>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
Message-ID: <1411570141-29960-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have initial support for the A80, as well a the datasheet.
Update the documents to reflect this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/arm/sunxi/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/sunxi/README b/Documentation/arm/sunxi/README
index 7945238..9477d6e 100644
--- a/Documentation/arm/sunxi/README
+++ b/Documentation/arm/sunxi/README
@@ -49,4 +49,5 @@ SunXi family
 
     * Quad ARM Cortex-A15, Quad ARM Cortex-A7 based SoCs
       - Allwinner A80
-        + Not Supported
\ No newline at end of file
+        + Datasheet
+	  http://dl.linux-sunxi.org/A80/A80_Datasheet_Revision_1.0_0404.pdf
-- 
2.1.0
