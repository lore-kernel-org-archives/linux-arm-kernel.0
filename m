From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 16 Aug 2012 15:13:13 +0300
Subject: [PATCH v2 1/3] mfd: twl6040: Fix GPO mask
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1345119195-7490-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/mfd/twl6040.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index eaad49f..269b706 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -143,7 +143,7 @@
 
 #define TWL6040_GPO1			0x01
 #define TWL6040_GPO2			0x02
-#define TWL6040_GPO3			0x03
+#define TWL6040_GPO3			0x04
 
 /* ACCCTL (0x2D) fields */
 
-- 
1.7.8.6
