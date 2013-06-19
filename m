From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Jun 2013 10:53:04 -0700
Subject: [PATCH RFC 2/2] arm: multi_v7_defconfig: Enable initrd/initramfs
 support
In-Reply-To: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1371664384-24974-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_BLK_DEV_INITRD to the defconfig to support
initramfs and initrd.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d5f0d76..2deda6d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -83,3 +83,4 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_SIRF_DMA=y
 CONFIG_DW_DMAC=y
+CONFIG_BLK_DEV_INITRD=y
-- 
1.8.3.1
