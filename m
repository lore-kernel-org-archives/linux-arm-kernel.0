From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 21 Jan 2011 16:03:57 -0200
Subject: [PATCH] ARM: imx: Add VPR200 and MX51_3DS entries to uncompress.h
Message-ID: <1295633037-3475-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 3a70ebf..ff469c4 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -95,6 +95,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MX35_3DS:
 	case MACH_TYPE_PCM043:
 	case MACH_TYPE_LILLY1131:
+	case MACH_TYPE_VPR200:
 		uart_base = MX3X_UART1_BASE_ADDR;
 		break;
 	case MACH_TYPE_MAGX_ZN5:
@@ -102,6 +103,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 		break;
 	case MACH_TYPE_MX51_BABBAGE:
 	case MACH_TYPE_EUKREA_CPUIMX51SD:
+	case MACH_TYPE_MX51_3DS:
 		uart_base = MX51_UART1_BASE_ADDR;
 		break;
 	case MACH_TYPE_MX50_RDP:
-- 
1.6.0.4
