From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:21:38 +0200
Subject: [PATCH 5/6] ARM: multi_v7_defconfig: Enable r8a7744 SoC
In-Reply-To: <cover.1538122547.git.horms+renesas@verge.net.au>
References: <cover.1538122547.git.horms+renesas@verge.net.au>
Message-ID: <4f743344ddedca8edb440b3fb8e67ba6e292b4f6.1538122547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Enable recently added r8a7744 (RZ/G1N) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dec755c939bb..2b2cf6af5bdc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -79,6 +79,7 @@ CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7744=y
 CONFIG_ARCH_R8A7745=y
 CONFIG_ARCH_R8A77470=y
 CONFIG_ARCH_R8A7778=y
-- 
2.11.0
