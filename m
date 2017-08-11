From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Fri, 11 Aug 2017 18:00:33 +0800
Subject: [PATCH 3/3] core-arm: add a member about dma_map_ops in dev_archdata
 struct
Message-ID: <1502445633-33772-1-git-send-email-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 arch/arm/include/asm/device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 220ba20..c93d3df 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -7,6 +7,7 @@
 #define ASMARM_DEVICE_H
 
 struct dev_archdata {
+const struct dma_map_ops        *dma_ops;
 #ifdef CONFIG_DMABOUNCE
 	struct dmabounce_device_info *dmabounce;
 #endif
-- 
2.1.0.27.g96db324
