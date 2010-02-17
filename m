From: carsten.behling@garz-fricke.com (Carsten Behling)
Date: Wed, 17 Feb 2010 18:01:00 +0100
Subject: [PATCH 2/2] add mx3 cupid bsp cleanup
Message-ID: <D99582E5322435468A77E74BB0039E7B176E1F3BBB@SRV02.hamburg.garz-fricke.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I added the board to arch/arm/plat-mxc/include/mach/uncompress.h.

Carsten

Signed-off-by: Carsten Behling <carsten.behling@garz-fricke.com>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index d189f00..1a0b311 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -94,6 +94,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
        case MACH_TYPE_MX35_3DS:
        case MACH_TYPE_PCM043:
        case MACH_TYPE_LILLY1131:
+       case MACH_TYPE_GUF_CUPID:
                uart_base = MX3X_UART1_BASE_ADDR;
                break;
        case MACH_TYPE_MAGX_ZN5:
--
1.6.0.2
