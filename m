From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 19 Dec 2013 16:27:55 +0100
Subject: [PATCH] MAINTAINERS: Setup proper record for Xilinx Zynq
Message-ID: <3dac35ceaef6199c5a58bba17ce59f1ef0e2bf1e.1387466706.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup correct zynq entry.
- Add missing cadence_ttc_timer maintainership
- Add zynq wildcard
- Add xilinx wildcard

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1344816..5f6e3ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1366,6 +1366,9 @@ T:	git git://git.xilinx.com/linux-xlnx.git
 S:	Supported
 F:	arch/arm/mach-zynq/
 F:	drivers/cpuidle/cpuidle-zynq.c
+N:	zynq
+N:	xilinx
+F:	drivers/clocksource/cadence_ttc_timer.c

 ARM SMMU DRIVER
 M:	Will Deacon <will.deacon@arm.com>
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/7b356379/attachment-0001.sig>
