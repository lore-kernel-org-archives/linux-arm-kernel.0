From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri,  6 Nov 2015 23:57:58 +0800
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
Message-ID: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HAVE_LATENCYTOP_SUPPORT in Kconfig, so that
we can enable this feature on ARM64

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 851fe11..782b5bd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -103,6 +103,10 @@ config ARCH_PHYS_ADDR_T_64BIT
 config MMU
 	def_bool y
 
+config HAVE_LATENCYTOP_SUPPORT
+	bool
+	default y
+
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
-- 
1.9.1
