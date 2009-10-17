From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 17 Oct 2009 15:13:00 +0200
Subject: [PATCH 4/4] ARM: MX3: add MX3X_UART1_BASE_ADDR for uncompression on
	lilly1131
In-Reply-To: <1255785180-18501-4-git-send-email-daniel@caiaq.de>
References: <1255785180-18501-1-git-send-email-daniel@caiaq.de>
	<1255785180-18501-2-git-send-email-daniel@caiaq.de>
	<1255785180-18501-3-git-send-email-daniel@caiaq.de>
	<1255785180-18501-4-git-send-email-daniel@caiaq.de>
Message-ID: <1255785180-18501-5-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: J?rg Knobloch <knobloch@incostartec.com>
Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 082a390..0e12876 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -94,6 +94,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MX31ADS:
 	case MACH_TYPE_MX35_3DS:
 	case MACH_TYPE_PCM043:
+	case MACH_TYPE_LILLY1131:
 		uart_base = MX3X_UART1_BASE_ADDR;
 		break;
 	case MACH_TYPE_MAGX_ZN5:
-- 
1.6.3.3
