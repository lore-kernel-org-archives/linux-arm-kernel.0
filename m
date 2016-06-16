From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 16 Jun 2016 14:23:57 +0900
Subject: [PATCH 1/2] ARM: shmobile: defconfig: Enable r8a7792 SoC
In-Reply-To: <1466054638-11326-1-git-send-email-horms+renesas@verge.net.au>
References: <1466054638-11326-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466054638-11326-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for r8a7792 SoC in shmobile_defconfig.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index f2d635566a13..baa07a46a88b 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -17,6 +17,7 @@ CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7792=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-- 
2.1.4
