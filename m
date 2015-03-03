From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:15 +0100
Subject: [PATCH v3 20/20] ARM: configs: enable Marvell Armada 39x in
 multi_v7_defconfig
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the introduction of the Marvell Armada 39x support, let's
enable this support by default in multi_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <arm@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e8a4c95..32d5399 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -16,6 +16,7 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
 CONFIG_MACH_ARMADA_38X=y
+CONFIG_MACH_ARMADA_39X=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_MACH_DOVE=y
 CONFIG_ARCH_BCM=y
-- 
2.1.0
