From: jassi.brar@samsung.com (Jassi Brar)
Date: Wed, 11 Nov 2009 14:51:13 +0900
Subject: [PATCH 1/2] S3C64XX PCM: Define PCM Controller base registers
Message-ID: <1257918673-26126-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6400/include/mach/map.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index fc8b223..866be31 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -48,6 +48,8 @@
 #define S3C64XX_PA_IIS1		(0x7F003000)
 #define S3C64XX_PA_TIMER	(0x7F006000)
 #define S3C64XX_PA_IIC0		(0x7F004000)
+#define S3C64XX_PA_PCM0		(0x7F009000)
+#define S3C64XX_PA_PCM1		(0x7F00A000)
 #define S3C64XX_PA_IISV4	(0x7F00D000)
 #define S3C64XX_PA_IIC1		(0x7F00F000)
 
-- 
1.6.2.5
