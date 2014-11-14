From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 14 Nov 2014 10:21:53 +0100
Subject: [PATCH] ARM: zynq: Remove secondary_startup() declaration from header
Message-ID: <f8646bfc1a5c6bd86103cc237dca2dec2ca9efa6.1415956908.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

secondary_startup() in the header is not needed at all.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/mach-zynq/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 2bc71273c73c..382c60e9aa16 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -29,7 +29,6 @@ extern void zynq_slcr_cpu_state_write(int cpu, bool die);
 extern u32 zynq_slcr_get_device_id(void);

 #ifdef CONFIG_SMP
-extern void secondary_startup(void);
 extern char zynq_secondary_trampoline;
 extern char zynq_secondary_trampoline_jump;
 extern char zynq_secondary_trampoline_end;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/b89ac4b8/attachment.sig>
