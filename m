From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 02 Sep 2014 09:19:16 +0530
Subject: [RESEND PATCH] arm64: dts: add <dt-bindings/> symlink
Message-ID: <1409629756-14304-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add symlink to include/dt-bindings from arch/arm64/boot/dts/include/ to
match the ones in ARM architectures so that preprocessed device
tree files can include various useful constant definitions.

See commit c58299aa8754 ("kbuild: create an "include chroot" for DT bindings")
merged in v3.10-rc1 for details.

CC: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---

Resubmitting this change as now it will be required for Samsung ARM64
based SoC.

Initial discussion can be found at here 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/228225.html

 arch/arm64/boot/dts/include/dt-bindings |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 120000 arch/arm64/boot/dts/include/dt-bindings

diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..68ae388
--- /dev/null
+++ b/arch/arm64/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
-- 
1.7.4.4
