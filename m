From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 28 Aug 2011 20:09:37 +0200
Subject: [PATCH 2/4] S3C2443: Define constant for HSSPI pclk
In-Reply-To: <201108282006.31667.heiko@sntech.de>
References: <201108282006.31667.heiko@sntech.de>
Message-ID: <201108282009.37874.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's the same clock for 2443/2416/2450.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
index 5e06c72..df6434f 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
@@ -102,6 +102,7 @@
 #define S3C2443_PCLKCON_UART3		(1<<3)
 #define S3C2443_PCLKCON_IIC		(1<<4)
 #define S3C2443_PCLKCON_SDI		(1<<5)
+#define S3C2443_PCLKCON_HSSPI		(1<<6)
 #define S3C2443_PCLKCON_ADC		(1<<7)
 #define S3C2443_PCLKCON_AC97		(1<<8)
 #define S3C2443_PCLKCON_IIS		(1<<9)
-- 
1.7.2.3
