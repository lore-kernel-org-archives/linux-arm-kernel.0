From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 6 Jan 2011 19:05:39 +0800
Subject: [PATCH 1/1] arm: mxc: move IOMUX_CONFIG_SION definition to iomux-v3.h
Message-ID: <1294311939-15503-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |    1 -
 arch/arm/plat-mxc/include/mach/iomux-v3.h   |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 5deee01..2673007 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -34,7 +34,6 @@ typedef enum iomux_config {
 	IOMUX_CONFIG_ALT6,
 	IOMUX_CONFIG_ALT7,
 	IOMUX_CONFIG_GPIO, /* added to help user use GPIO mode */
-	IOMUX_CONFIG_SION = 0x1 << 4, /* LOOPBACK:MUX SION bit */
 } iomux_pin_cfg_t;
 
 /* These 2 defines are for pins that may not have a mux register, but could
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index 2277b01..82620af 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -105,6 +105,7 @@ typedef u64 iomux_v3_cfg_t;
 #define PAD_CTL_SRE_FAST		(1 << 0)
 #define PAD_CTL_SRE_SLOW		(0 << 0)
 
+#define IOMUX_CONFIG_SION		(0x1 << 4)
 
 #define MX51_NUM_GPIO_PORT	4
 
-- 
1.6.3.3
