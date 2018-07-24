From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 24 Jul 2018 16:47:17 +0100
Subject: [PATCH 2/3] arm64: Add Renesas R8A774A1 support
In-Reply-To: <1532447238-13486-1-git-send-email-biju.das@bp.renesas.com>
References: <1532447238-13486-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1532447238-13486-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration option for the RZ/G2M (R8A774A1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac3..6b9f487 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -178,6 +178,12 @@ config ARCH_RENESAS
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
+config ARCH_R8A774A1
+	bool "Renesas RZ/G2M SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/G2M SoC.
+
 config ARCH_R8A7795
 	bool "Renesas R-Car H3 SoC Platform"
 	depends on ARCH_RENESAS
-- 
2.7.4
