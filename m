From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 17 Oct 2013 07:46:02 +0530
Subject: [PATCH 29/29] dmaengine: remove unused DMA_SUCCESS
In-Reply-To: <1381940926-25564-29-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-29-git-send-email-vinod.koul@intel.com>
Message-ID: <1381976162-14617-1-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after all the users are converted

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/linux/dmaengine.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 683c380..4b460a6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -55,7 +55,6 @@ enum dma_status {
 	DMA_IN_PROGRESS,
 	DMA_PAUSED,
 	DMA_ERROR,
-	DMA_SUCCESS,
 };
 
 /**
-- 
1.7.0.4
