From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:18 +0200
Subject: [PATCH 0097/1529] Fix typo
Message-ID: <20160521114918.4399-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-imx/iomux-mx3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
index 2e4a0dd..9a11b71 100644
--- a/arch/arm/mach-imx/iomux-mx3.h
+++ b/arch/arm/mach-imx/iomux-mx3.h
@@ -129,7 +129,7 @@ int mxc_iomux_setup_multiple_pins(const unsigned int *pin_list, unsigned count,
 void mxc_iomux_release_pin(unsigned int pin);
 /*
  * releases multiple pins
- * convenvient way to call the above function with tables
+ * convenient way to call the above function with tables
  */
 void mxc_iomux_release_multiple_pins(const unsigned int *pin_list, int count);
 
-- 
2.8.2.534.g1f66975
