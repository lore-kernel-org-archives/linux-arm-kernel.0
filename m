From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 Jun 2010 11:57:03 +0300
Subject: [PATCH -next 2/2] mx25: add PWM4 to iomux
In-Reply-To: <cover.1277369614.git.baruch@tkos.co.il>
References: <cover.1277369614.git.baruch@tkos.co.il>
Message-ID: <dd3597a30dbdd41f14c207e36123616abab78fde.1277369614.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index cbc67c7..593c47c 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -252,6 +252,7 @@
 #define MX25_PAD_OE_ACD__GPIO_1_25	IOMUX_PAD(0x30c, 0x114, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_CONTRAST__CONTRAST	IOMUX_PAD(0x310, 0x118, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_CONTRAST__PWM4_PWMO	IOMUX_PAD(0x310, 0x118, 0x14, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_CONTRAST__FEC_CRS	IOMUX_PAD(0x310, 0x118, 0x15, 0x508, 1, NO_PAD_CTRL)
 
 #define MX25_PAD_PWM__PWM		IOMUX_PAD(0x314, 0x11c, 0x10, 0, 0, NO_PAD_CTRL)
-- 
1.7.1
