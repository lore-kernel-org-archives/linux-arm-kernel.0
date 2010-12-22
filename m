From: nm@ti.com (Nishanth Menon)
Date: Wed, 22 Dec 2010 12:14:36 -0600
Subject: [PATCH] OMAP3: fix typo in OMAP3_IVA_MASK
Message-ID: <1293041676-1206-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arno Steffen <arno.steffen@googlemail.com>

OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT

Signed-off-by: Arno Steffen <arno.steffen@googlemail.com>
---
Tony,
	looking at head:
	http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/control.h/control.h;h=6e5f7e512ff7da063dbeb9448670f38cefd486e6;hb=HEAD
	This is a missing fix we have'nt incorporated yet.

V2: posted to l-o and l-a and rebased to 2.6.37-rc7

V1: http://marc.info/?t=129077184800003&r=1&w=2

 arch/arm/mach-omap2/control.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..5325297 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -309,7 +309,7 @@
 #define		FEAT_SGX_NONE		2
 
 #define OMAP3_IVA_SHIFT			12
-#define OMAP3_IVA_MASK			(1 << OMAP3_SGX_SHIFT)
+#define OMAP3_IVA_MASK			(1 << OMAP3_IVA_SHIFT)
 #define		FEAT_IVA		0
 #define		FEAT_IVA_NONE		1
 
-- 
1.6.3.3
