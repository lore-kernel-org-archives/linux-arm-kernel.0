From: b18965@freescale.com (Alison Wang)
Date: Tue, 18 Apr 2017 16:30:55 +0800
Subject: [PATCH] ARM: configs: Add multi_v7_lpae.config to support ARM_LPAE
Message-ID: <1492504255-9418-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some ARMv7 platforms need to enable ARM_LPAE to access memory beyond
the 4GB limit, this patch is to add multi_v7_lpae.config to support the
Large Physical Address Extension. The building will use
multi_v7_defconfig + multi_v7_lpae.config as the defconfig.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 arch/arm/configs/multi_v7_lpae.config | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/arm/configs/multi_v7_lpae.config

diff --git a/arch/arm/configs/multi_v7_lpae.config b/arch/arm/configs/multi_v7_lpae.config
new file mode 100644
index 0000000..cd13d2d
--- /dev/null
+++ b/arch/arm/configs/multi_v7_lpae.config
@@ -0,0 +1,2 @@
+# Support for the Large Physical Address Extension
+CONFIG_ARM_LPAE=y
-- 
2.1.0.27.g96db324
