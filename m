From: yguerrini@tomshardware.fr (Yannick Guerrini)
Date: Mon, 2 Mar 2015 15:45:05 +0100
Subject: [PATCH] ARM: imx: Fix trivial typo in comments
Message-ID: <1425307505-1432-1-git-send-email-yguerrini@tomshardware.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change 'mutliple' to 'multiple'

Signed-off-by: Yannick Guerrini <yguerrini@tomshardware.fr>
---
 arch/arm/mach-imx/iomux-mx3.h | 2 +-
 arch/arm/mach-imx/iomux-v3.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
index 0a5adba..2e4a0dd 100644
--- a/arch/arm/mach-imx/iomux-mx3.h
+++ b/arch/arm/mach-imx/iomux-mx3.h
@@ -114,7 +114,7 @@ enum iomux_gp_func {
  */
 int mxc_iomux_alloc_pin(unsigned int pin, const char *label);
 /*
- * setups mutliple pins
+ * setups multiple pins
  * convenient way to call the above function with tables
  */
 int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
diff --git a/arch/arm/mach-imx/iomux-v3.h b/arch/arm/mach-imx/iomux-v3.h
index 2fa3b54..cb45ae5 100644
--- a/arch/arm/mach-imx/iomux-v3.h
+++ b/arch/arm/mach-imx/iomux-v3.h
@@ -128,7 +128,7 @@ typedef u64 iomux_v3_cfg_t;
 int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad);
 
 /*
- * setups mutliple pads
+ * setups multiple pads
  * convenient way to call the above function with tables
  */
 int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count);
-- 
1.9.5.msysgit.0
