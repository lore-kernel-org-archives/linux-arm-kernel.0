From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:38 +0530
Subject: [RESEND PATCH 8/8] dts/Makefile: Add build support for LS2085a QDS &
 RDB board DTS
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-9-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds build support for LS2085a QDS & RDB board DTS files
in the arm64 DTS Makefile.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/freescale/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 4f2de3e7..a4fb84b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_FSL_LS2085A) += fsl-ls2085a-simu.dtb
+dtb-$(CONFIG_ARCH_FSL_LS2085A) += fsl-ls2085a-qds.dtb fsl-ls2085a-rdb.dtb fsl-ls2085a-simu.dtb
  
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-- 
1.7.9.5
