From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:07 +0900
Subject: [PATCH 05/17] ARM: S5P6450: Define base addresses for I2S
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562007-19748-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p64x0/include/mach/map.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
index 31e5341..4d3d332 100644
--- a/arch/arm/mach-s5p64x0/include/mach/map.h
+++ b/arch/arm/mach-s5p64x0/include/mach/map.h
@@ -63,6 +63,8 @@
 #define S5P64X0_PA_HSMMC(x)	(0xED800000 + ((x) * 0x100000))
 
 #define S5P64X0_PA_I2S		(0xF2000000)
+#define S5P6450_PA_I2S1		0xF2800000
+#define S5P6450_PA_I2S2		0xF2900000
 
 #define S5P64X0_PA_PCM		(0xF2100000)
 
-- 
1.6.2.5
