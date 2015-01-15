From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 15 Jan 2015 08:48:55 +0100
Subject: [PATCH] ARM: zynq: Setup default gpio number for Xilinx Zynq
Message-ID: <a6813ce56fdabddb69a4b1e99e3b10bdb03ac7b1.1421308133.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97d07ed60a0b..da77f786f99f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1488,7 +1488,7 @@ config ARM_PSCI
 # selected platforms.
 config ARCH_NR_GPIO
 	int
-	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
+	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA || ARCH_ZYNQ
 	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
 		SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default 416 if ARCH_SUNXI
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/5c8dff8c/attachment.sig>
