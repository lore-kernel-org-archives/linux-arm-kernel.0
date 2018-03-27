From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 27 Mar 2018 15:37:23 +0100
Subject: [PATCH  12/12] ARM: multi_v7_defconfig: Enable r8a77470 SoC
In-Reply-To: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
References: <1522161443-54428-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1522161443-54428-13-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable recently added r8a77470 (RZ/G1C) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c1e045a..3623900 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -90,6 +90,7 @@ CONFIG_ARCH_R8A73A4=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_ARCH_R8A7743=y
 CONFIG_ARCH_R8A7745=y
+CONFIG_ARCH_R8A7747=y
 CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
-- 
2.7.4
