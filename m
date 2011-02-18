From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 18 Feb 2011 12:36:15 +0800
Subject: [PATCH RESEND 2/4] ARM: imx53_loco add uncompress print
In-Reply-To: <1298003777-7687-1-git-send-email-richard.zhao@freescale.com>
References: <1298003777-7687-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1298003777-7687-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index e634d6c..b702884 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -111,6 +111,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 		uart_base = MX50_UART1_BASE_ADDR;
 		break;
 	case MACH_TYPE_MX53_EVK:
+	case MACH_TYPE_MX53_LOCO:
 		uart_base = MX53_UART1_BASE_ADDR;
 		break;
 	default:
-- 
1.7.1
