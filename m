From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 28 Jun 2016 14:01:28 +0200
Subject: [PATCH v3 2/2] Update ARM/TANGO section
In-Reply-To: <57726597.8030501@sigmadesigns.com>
References: <57726597.8030501@sigmadesigns.com>
Message-ID: <57726718.1080503@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use regex pattern to match tango-specific files.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1b090f86e0d..b8140a3f5764 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1734,8 +1734,7 @@ ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
-F:	arch/arm/mach-tango/
-F:	arch/arm/boot/dts/tango*
+N:	tango
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
2.9.0
