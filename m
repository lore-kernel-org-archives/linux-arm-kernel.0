From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 28 Jul 2011 16:29:55 +0200
Subject: [RFC PATCH 6/9] atmel_pdc: add ATMEL_PDC_SCND_BUF_OFF
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1311863398-31579-7-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add define for the offset value between first and second buffer registers.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 include/linux/atmel_pdc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/atmel_pdc.h b/include/linux/atmel_pdc.h
index 5058a31..63499ce 100644
--- a/include/linux/atmel_pdc.h
+++ b/include/linux/atmel_pdc.h
@@ -33,4 +33,6 @@
 
 #define ATMEL_PDC_PTSR		0x124	/* Transfer Status Register */
 
+#define ATMEL_PDC_SCND_BUF_OFF	0x10	/* Offset between first and second buffer registers */
+
 #endif
-- 
1.7.0.4
