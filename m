From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Nov 2016 10:23:54 +0100
Subject: [PATCH] ARM: shmobile: defconfig: Enable CONFIG_CGROUPS
In-Reply-To: <cover.1478078446.git.horms+renesas@verge.net.au>
References: <cover.1478078446.git.horms+renesas@verge.net.au>
Message-ID: <a604a37d46b80899d5a09d937fdd670e93af690d.1478078446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Enable support for CONFIG_CGROUPS in shmobile_defconfig.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index baa07a46a88b..1b0f8ae36fb3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
-- 
2.7.0.rc3.207.g0ac5344
