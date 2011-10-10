From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:27:56 -0700
Subject: [PATCH v2 06/14] ARM: tegra: pcie: include board.h
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes:

arch/arm/mach-tegra/pcie.c:908:12: warning: symbol 'tegra_pcie_init' was not declared. Should it be static?

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/pcie.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 6b0c235..f7c89ee 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -41,6 +41,8 @@
 #include <mach/clk.h>
 #include <mach/powergate.h>
 
+#include "board.h"
+
 /* register definitions */
 #define AFI_OFFSET	0x3800
 #define PADS_OFFSET	0x3000
-- 
1.7.4.1
