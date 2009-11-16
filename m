From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:54 +0100
Subject: [PATCH 11/25] imx: reformat mx25.h to match the other platform
	includes
In-Reply-To: <1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx25.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index ec64bd9..91e7381 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -1,14 +1,14 @@
 #ifndef __MACH_MX25_H__
 #define __MACH_MX25_H__
 
-#define MX25_AIPS1_BASE_ADDR		0x43F00000
-#define MX25_AIPS1_BASE_ADDR_VIRT	0xFC000000
+#define MX25_AIPS1_BASE_ADDR		0x43f00000
+#define MX25_AIPS1_BASE_ADDR_VIRT	0xfc000000
 #define MX25_AIPS1_SIZE			SZ_1M
-#define MX25_AIPS2_BASE_ADDR		0x53F00000
-#define MX25_AIPS2_BASE_ADDR_VIRT	0xFC200000
+#define MX25_AIPS2_BASE_ADDR		0x53f00000
+#define MX25_AIPS2_BASE_ADDR_VIRT	0xfc200000
 #define MX25_AIPS2_SIZE			SZ_1M
 #define MX25_AVIC_BASE_ADDR		0x68000000
-#define MX25_AVIC_BASE_ADDR_VIRT	0xFC400000
+#define MX25_AVIC_BASE_ADDR_VIRT	0xfc400000
 #define MX25_AVIC_SIZE			SZ_1M
 
 #define MX25_IOMUXC_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xac000)
-- 
1.6.5.2
