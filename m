From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  2 May 2013 09:56:18 +0100
Subject: [PATCH] dmaengine: ste_dma40: Correct copy/paste error
Message-ID: <1367484978-3599-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'struct stedma40_half_channel_info's header comment says that it's
called 'struct stedma40_chan_cfg'. Let's straighten that out.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/platform_data/dma-ste-dma40.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/dma-ste-dma40.h b/include/linux/platform_data/dma-ste-dma40.h
index af0064e..288dc24 100644
--- a/include/linux/platform_data/dma-ste-dma40.h
+++ b/include/linux/platform_data/dma-ste-dma40.h
@@ -86,7 +86,7 @@ enum stedma40_xfer_dir {
 
 
 /**
- * struct stedma40_chan_cfg - dst/src channel configuration
+ * struct stedma40_half_channel_info - dst/src channel configuration
  *
  * @big_endian: true if the src/dst should be read as big endian
  * @data_width: Data width of the src/dst hardware
-- 
1.7.10.4
