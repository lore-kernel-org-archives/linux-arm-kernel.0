From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 21 Jul 2011 18:08:10 +0200
Subject: [PATCH] iMX28: Fix emi_ddr_open pinmux
Message-ID: <1311264490-5485-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-mxs/include/mach/iomux-mx28.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/iomux-mx28.h b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
index f50fefd..1a95ecd 100644
--- a/arch/arm/mach-mxs/include/mach/iomux-mx28.h
+++ b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
@@ -203,7 +203,7 @@
 #define MX28_PAD_EMI_WEN__EMI_WEN			MXS_IOMUX_PAD_NAKED(6, 21, PAD_MUXSEL_0)
 #define MX28_PAD_EMI_CE0N__EMI_CE0N			MXS_IOMUX_PAD_NAKED(6, 22, PAD_MUXSEL_0)
 #define MX28_PAD_EMI_CE1N__EMI_CE1N			MXS_IOMUX_PAD_NAKED(6, 23, PAD_MUXSEL_0)
-#define MX28_PAD_EMI_CKE__EMI_CKE			MXS_IOMUX_PAD_NAKED(6, 24, PAD_MUXSEL_0)
+#define MX28_PAD_EMI_CKE__EMI_CKE			MXS_IOMUX_PAD_NAKED(6, 26, PAD_MUXSEL_0)
 
 /* MUXSEL_1 */
 #define MX28_PAD_GPMI_D00__SSP1_D0			MXS_IOMUX_PAD_NAKED(0,  0, PAD_MUXSEL_1)
-- 
1.7.5.3
