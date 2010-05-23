From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:43 +0200
Subject: [PATCH 134/199] arch/arm/mach-clps711x/Makefile.boot: Checkpatch
	cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-7-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-clps711x/Makefile.boot:2: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-clps711x/Makefile.boot |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-clps711x/Makefile.boot b/arch/arm/mach-clps711x/Makefile.boot
index d3d2933..a51fcef 100644
--- a/arch/arm/mach-clps711x/Makefile.boot
+++ b/arch/arm/mach-clps711x/Makefile.boot
@@ -1,7 +1,6 @@
 # The standard locations for stuff on CLPS711x type processors
-   zreladdr-y				:= 0xc0028000 
+   zreladdr-y				:= 0xc0028000
 params_phys-y				:= 0xc0000100
 # Should probably have some agreement on these...
 initrd_phys-$(CONFIG_ARCH_P720T)	:= 0xc0400000
 initrd_phys-$(CONFIG_ARCH_CDB89712)	:= 0x00700000
-
-- 
1.7.1.251.gf80a2
