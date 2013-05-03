From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:20 +0100
Subject: [PATCH 34/63] dmaengine: ste_dma40: Correct copy/paste error
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-35-git-send-email-lee.jones@linaro.org>
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
