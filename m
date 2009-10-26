From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 26 Oct 2009 11:55:59 +0100
Subject: [PATCH 5/5] ARM: MX3: add MX3X_UART1_BASE_ADDR for uncompression on
	lilly1131
In-Reply-To: <1256554559-17828-5-git-send-email-daniel@caiaq.de>
References: <1256554559-17828-1-git-send-email-daniel@caiaq.de>
	<1256554559-17828-2-git-send-email-daniel@caiaq.de>
	<1256554559-17828-3-git-send-email-daniel@caiaq.de>
	<1256554559-17828-4-git-send-email-daniel@caiaq.de>
	<1256554559-17828-5-git-send-email-daniel@caiaq.de>
Message-ID: <1256554559-17828-6-git-send-email-daniel@caiaq.de>
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
1.6.5
