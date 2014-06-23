From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:25:34 +0900
Subject: [PATCH 3/4] ARM: shmobile: Enable PM_RUNTIME in defconfig
In-Reply-To: <cover.1403487196.git.horms+renesas@verge.net.au>
References: <cover.1403487196.git.horms+renesas@verge.net.au>
Message-ID: <6e2776388a85e6b41e8cc816ece318d944fc3388.1403487196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 8cde033..94d7736 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -35,6 +35,7 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.0.0.rc2
