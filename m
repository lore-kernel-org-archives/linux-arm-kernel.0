From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Oct 2014 13:44:25 +0200
Subject: [PATCH 2/3] ARM: zynq: Enable generic allocator
In-Reply-To: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
References: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
Message-ID: <fe2f771661d20f629ecc78a251263d9b9e72f114.1412595859.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable generic allocator by default because it is used by OCMC driver.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index aaa5162c1509..d447adefd397 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -5,6 +5,7 @@ config ARCH_ZYNQ
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER if !CPU_FREQ
 	select CADENCE_TTC_TIMER
+	select GENERIC_ALLOCATOR
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ICST
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/02812038/attachment-0001.sig>
