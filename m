From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Wed, 30 Dec 2015 09:43:49 +0800
Subject: [PATCH v4 3/6] ARM: config: hisi: enable CONFIG_RESET_CONTROLLER
In-Reply-To: <1451439832-13927-1-git-send-email-xuejiancheng@huawei.com>
References: <1451439832-13927-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1451439832-13927-4-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable CONFIG_RESET_CONTROLLER in hisi_defconfig

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/configs/hisi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index b2e340b..ba62c07 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -75,6 +75,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_PL330_DMA=y
 CONFIG_PWM=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_EXT4_FS=y
 CONFIG_TMPFS=y
-- 
1.9.1
