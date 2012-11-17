From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Nov 2012 17:57:22 +0400
Subject: [PATCH v3 16/18] ARM: clps711x: Rename board files to match
 functionality
In-Reply-To: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
Message-ID: <1353160644-22446-17-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Makefile                    |   12 ++++++------
 .../mach-clps711x/{autcpu12.c => board-autcpu12.c} |    0
 .../mach-clps711x/{cdb89712.c => board-cdb89712.c} |    0
 .../mach-clps711x/{clep7312.c => board-clep7312.c} |    0
 .../mach-clps711x/{edb7211.c => board-edb7211.c}   |    0
 .../mach-clps711x/{fortunet.c => board-fortunet.c} |    0
 arch/arm/mach-clps711x/{p720t.c => board-p720t.c}  |    0
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/mach-clps711x/{autcpu12.c => board-autcpu12.c} (100%)
 rename arch/arm/mach-clps711x/{cdb89712.c => board-cdb89712.c} (100%)
 rename arch/arm/mach-clps711x/{clep7312.c => board-clep7312.c} (100%)
 rename arch/arm/mach-clps711x/{edb7211.c => board-edb7211.c} (100%)
 rename arch/arm/mach-clps711x/{fortunet.c => board-fortunet.c} (100%)
 rename arch/arm/mach-clps711x/{p720t.c => board-p720t.c} (100%)

diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index 9cf2d1c..992995a 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -9,9 +9,9 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-obj-$(CONFIG_ARCH_AUTCPU12) += autcpu12.o
-obj-$(CONFIG_ARCH_CDB89712) += cdb89712.o
-obj-$(CONFIG_ARCH_CLEP7312) += clep7312.o
-obj-$(CONFIG_ARCH_EDB7211)  += edb7211.o
-obj-$(CONFIG_ARCH_FORTUNET) += fortunet.o
-obj-$(CONFIG_ARCH_P720T)    += p720t.o
+obj-$(CONFIG_ARCH_AUTCPU12)	+= board-autcpu12.o
+obj-$(CONFIG_ARCH_CDB89712)	+= board-cdb89712.o
+obj-$(CONFIG_ARCH_CLEP7312)	+= board-clep7312.o
+obj-$(CONFIG_ARCH_EDB7211)	+= board-edb7211.o
+obj-$(CONFIG_ARCH_FORTUNET)	+= board-fortunet.o
+obj-$(CONFIG_ARCH_P720T)	+= board-p720t.o
diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
similarity index 100%
rename from arch/arm/mach-clps711x/autcpu12.c
rename to arch/arm/mach-clps711x/board-autcpu12.c
diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
similarity index 100%
rename from arch/arm/mach-clps711x/cdb89712.c
rename to arch/arm/mach-clps711x/board-cdb89712.c
diff --git a/arch/arm/mach-clps711x/clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
similarity index 100%
rename from arch/arm/mach-clps711x/clep7312.c
rename to arch/arm/mach-clps711x/board-clep7312.c
diff --git a/arch/arm/mach-clps711x/edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
similarity index 100%
rename from arch/arm/mach-clps711x/edb7211.c
rename to arch/arm/mach-clps711x/board-edb7211.c
diff --git a/arch/arm/mach-clps711x/fortunet.c b/arch/arm/mach-clps711x/board-fortunet.c
similarity index 100%
rename from arch/arm/mach-clps711x/fortunet.c
rename to arch/arm/mach-clps711x/board-fortunet.c
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/board-p720t.c
similarity index 100%
rename from arch/arm/mach-clps711x/p720t.c
rename to arch/arm/mach-clps711x/board-p720t.c
-- 
1.7.8.6
