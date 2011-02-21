From: Frank.Li@freescale.com (Frank Li)
Date: Mon, 21 Feb 2011 14:28:10 +0800
Subject: [PATCH] ARM: imx53_smd add uncompress print
Message-ID: <1298269690-23705-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index b702884..7412558 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -112,6 +112,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 		break;
 	case MACH_TYPE_MX53_EVK:
 	case MACH_TYPE_MX53_LOCO:
+	case MACH_TYPE_MX53_SMD:
 		uart_base = MX53_UART1_BASE_ADDR;
 		break;
 	default:
-- 
1.6.3.3
