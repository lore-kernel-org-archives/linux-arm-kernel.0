From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 3 Sep 2014 20:43:13 +0530
Subject: [PATCH V3 5/6] arm64: dts/Makefile: Add support for FSL's LS2085A
 simulator model
In-Reply-To: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1409757194-28155-6-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds build support for FSL's LS2085A simulator model
in arm64 dts Makefile.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 arch/arm64/boot/dts/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c52bdb0..c6ed88662 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
+dtb-$(CONFIG_ARCH_FSL_LS2085A) += fsl-ls2085a-simu.dtb
 
 targets += dtbs
 targets += $(dtb-y)
-- 
1.7.9.5
