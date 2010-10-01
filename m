From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:40 -0700
Subject: [PATCH 16/47] DA850: Add LPSC id for MMCSD1 peripheral
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-17-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juha Kuikka <juha.kuikka@elektrobit.com>

Add LPSC id for DA850's MMCSD1 peripheral.

Signed-off-by: Juha Kuikka <juha.kuikka@elektrobit.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/psc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 983da6e..62b0858 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -172,6 +172,7 @@
 #define DA8XX_LPSC1_UART2		13
 #define DA8XX_LPSC1_LCDC		16
 #define DA8XX_LPSC1_PWM			17
+#define DA850_LPSC1_MMC_SD1		18
 #define DA8XX_LPSC1_ECAP		20
 #define DA830_LPSC1_EQEP		21
 #define DA850_LPSC1_TPTC2		21
-- 
1.7.2.1
