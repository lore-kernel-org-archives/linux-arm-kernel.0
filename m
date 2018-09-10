From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 10 Sep 2018 12:53:49 +0100
Subject: [PATCH 2/3] arm64: Add Renesas R8A774C0 support
In-Reply-To: <1536580430-17432-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1536580430-17432-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1536580430-17432-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration option for the RZ/G2E (R8A774C0) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b2e513e..0b65c03 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -170,6 +170,12 @@ config ARCH_R8A774A1
 	help
 	  This enables support for the Renesas RZ/G2M SoC.
 
+config ARCH_R8A774C0
+	bool "Renesas RZ/G2E SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/G2E SoC.
+
 config ARCH_R8A7795
 	bool "Renesas R-Car H3 SoC Platform"
 	depends on ARCH_RENESAS
-- 
2.7.4
