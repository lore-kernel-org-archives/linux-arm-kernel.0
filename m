From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 17 Sep 2018 16:06:29 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable r8a7744 SoC
In-Reply-To: <1537196790-4775-1-git-send-email-biju.das@bp.renesas.com>
References: <1537196790-4775-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1537196790-4775-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable recently added r8a7744 (RZ/G1N) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dec755c..2b2cf6a 100644
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
2.7.4
