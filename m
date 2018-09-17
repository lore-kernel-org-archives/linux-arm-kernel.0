From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 17 Sep 2018 16:08:47 +0100
Subject: [PATCH] ARM: shmobile: defconfig: Enable r8a7744 SoC
Message-ID: <1537196927-8241-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable recently added r8a7744 (RZ/G1N) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index f2b4007..d090022 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -13,6 +13,7 @@ CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7744=y
 CONFIG_ARCH_R8A7745=y
 CONFIG_ARCH_R8A77470=y
 CONFIG_ARCH_R8A7778=y
-- 
2.7.4
