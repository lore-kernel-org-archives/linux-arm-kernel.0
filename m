From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  9 Dec 2010 14:47:14 +0100
Subject: [PATCH 2/9] ARM i.MX51: rename IPU irqs
In-Reply-To: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1291902441-24712-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx51.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index fa3a2a5..873807f 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -251,8 +251,8 @@
 #define MX51_MXC_INT_IOMUX		7
 #define MX51_INT_NFC			8
 #define MX51_MXC_INT_VPU		9
-#define MX51_MXC_INT_IPU_ERR		10
-#define MX51_MXC_INT_IPU_SYN		11
+#define MX51_INT_IPU_ERR		10
+#define MX51_INT_IPU_SYN		11
 #define MX51_MXC_INT_GPU		12
 #define MX51_MXC_INT_RESV13		13
 #define MX51_MXC_INT_USB_H1		14
-- 
1.7.2.3
