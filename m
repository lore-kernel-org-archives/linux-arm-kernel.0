From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  7 Sep 2012 17:27:06 +0100
Subject: [PATCH v3 31/31] arm64: MAINTAINERS update
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1347035226-18649-32-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the MAINTAINERS file for the AArch64 Linux kernel
port.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdc0119..de368a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1209,6 +1209,12 @@ S:	Maintained
 F:	arch/arm/mach-pxa/z2.c
 F:	arch/arm/mach-pxa/include/mach/z2.h
 
+ARM64 PORT (AARCH64 ARCHITECTURE)
+M:	Catalin Marinas <catalin.marinas@arm.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/
+
 ASC7621 HARDWARE MONITOR DRIVER
 M:	George Joseph <george.joseph@fairview5.com>
 L:	lm-sensors at lm-sensors.org
