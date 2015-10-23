From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:02:01 +0530
Subject: [PATCH v4 12/12] dts/Makefile: Add build support for LS2080a QDS &
 RDB board DTS
In-Reply-To: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1445628721-10483-13-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds build support for LS2080a QDS & RDB board DTS files
in the arm64 DTS Makefile.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 932001a..c4957a4 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,3 +1,5 @@
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
  
 always		:= $(dtb-y)
-- 
1.7.9.5
