From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:41:59 +0100
Subject: [PATCH 3/9] pca100: Add board to uncompress.h
In-Reply-To: <1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
References: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 0e12876..a41bf57 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -83,6 +83,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MX27ADS:
 	case MACH_TYPE_PCM038:
 	case MACH_TYPE_MX21ADS:
+	case MACH_TYPE_PCA100:
 		uart_base = MX2X_UART1_BASE_ADDR;
 		break;
 	case MACH_TYPE_MX31LITE:
-- 
1.6.5.2
