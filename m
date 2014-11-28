From: long.wanglong@huawei.com (Wang Long)
Date: Fri, 28 Nov 2014 02:15:47 +0000
Subject: [PATCH 4/7] ARM: config: enable ARCH_HIP01
In-Reply-To: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
References: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <1417140950-67103-5-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make hip01 share the hisi_defconfig.
And add it into multi_v7_defconfig too.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 arch/arm/configs/hisi_defconfig     | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 1772505..33b0b76 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -6,6 +6,7 @@ CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_HIX5HD2=y
+CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9d7a32f..df335a2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -28,6 +28,7 @@ CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_HIX5HD2=y
+CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MESON=y
-- 
1.8.3.4
