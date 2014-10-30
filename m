From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 10:59:22 +0900
Subject: [PATCH] ARM: shmobile: ape6evm: Enable PM Runtime in defconfig
Message-ID: <1414634362-14204-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is consistent with other shmobile defconfigs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---

Based on renesas-devel-20141030-v3.18-rc2

 arch/arm/configs/ape6evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index b54b28f..db81d8c 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -33,6 +33,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=y
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.1.1
