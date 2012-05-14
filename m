From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 14 May 2012 21:46:10 +0400
Subject: [PATCH 3/4] ARM: clps711x: Added note about support EP731x CPU to
 Kconfig
In-Reply-To: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
References: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
Message-ID: <1337017571-16208-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf006d4..2437ff2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -373,12 +373,12 @@ config ARCH_HIGHBANK
 	  Support for the Calxeda Highbank SoC based boards.
 
 config ARCH_CLPS711X
-	bool "Cirrus Logic CLPS711x/EP721x-based"
+	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select CPU_ARM720T
 	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
 	help
-	  Support for Cirrus Logic 711x/721x based boards.
+	  Support for Cirrus Logic 711x/721x/731x based boards.
 
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
-- 
1.7.3.4
