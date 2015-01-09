From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  9 Jan 2015 14:45:41 -0800
Subject: [PATCH 4/4] MAINTAINERS: add a git entry for BMIPS-based BCM7xxx SoCs
In-Reply-To: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
References: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1420843541-5166-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a git tree entry for the BMIPS-based BCM7xxx SoCs located at
github.com/Broadcom/stblinux.git.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 18a199638105..0b62ff88dbbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2151,6 +2151,7 @@ BROADCOM BMIPS MIPS ARCHITECTURE
 M:	Kevin Cernekee <cernekee@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-mips at linux-mips.org
+T:	git git://git.github.com/broadcom/stblinux.git
 S:	Maintained
 F:	arch/mips/bmips/*
 F:	arch/mips/include/asm/mach-bmips/*
-- 
2.1.0
