From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Sat, 28 Nov 2015 15:19:24 +0800
Subject: [PATCH 4/5] ARM: config: enable ARCH_HI3519
Message-ID: <1448695164-31395-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable ARCH_HI3519 in hisi_defconfig

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/configs/hisi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index b2e340b..321d020 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -10,6 +10,7 @@ CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_HIX5HD2=y
 CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
+CONFIG_ARCH_HI3519=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_PREEMPT=y
-- 
1.9.1
