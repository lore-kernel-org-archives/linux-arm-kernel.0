From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:09 +0900
Subject: [PATCH 1/4] ARM: shmobile: ape6evm: Enable PM Runtime in defconfig
In-Reply-To: <cover.1415582943.git.horms+renesas@verge.net.au>
References: <cover.1415582943.git.horms+renesas@verge.net.au>
Message-ID: <c5940e115e188051f34a88ee705c5f81c6bf0e54.1415582943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is consistent with other shmobile defconfigs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
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
