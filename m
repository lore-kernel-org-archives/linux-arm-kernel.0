From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 May 2014 15:17:12 +0300
Subject: [PATCH v3 05/13] ARM/platform_data: edma: Remove queue_tc_mapping
 data from edma_soc_info
In-Reply-To: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1400242640-9902-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is no longer in use by the driver or board files.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/edma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 12f134b1493c..633e196ebdf2 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -175,7 +175,6 @@ struct edma_soc_info {
 	/* Resource reservation for other cores */
 	struct edma_rsv_info	*rsv;
 
-	s8	(*queue_tc_mapping)[2];
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
 };
-- 
1.9.3
