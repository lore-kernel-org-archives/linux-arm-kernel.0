From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:29:01 +0800
Subject: [PATCH 1/8] arm: mmp: add APBCP register definition
Message-ID: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

APBCP is a add on APBC area for pxa910

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/include/mach/addr-map.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/addr-map.h b/arch/arm/mach-mmp/include/mach/addr-map.h
index f88a44c..e4605da 100644
--- a/arch/arm/mach-mmp/include/mach/addr-map.h
+++ b/arch/arm/mach-mmp/include/mach/addr-map.h
@@ -37,6 +37,10 @@
 #define APBC_VIRT_BASE		(APB_VIRT_BASE + 0x015000)
 #define APBC_REG(x)		(APBC_VIRT_BASE + (x))
 
+/* extension apbc area*/
+#define APBCP_VIRT_BASE		(APB_VIRT_BASE + 0x03b000)
+#define APBCP_REG(x)		(APBCP_VIRT_BASE + (x))
+
 #define MPMU_VIRT_BASE		(APB_VIRT_BASE + 0x50000)
 #define MPMU_REG(x)		(MPMU_VIRT_BASE + (x))
 
-- 
1.7.0.4
