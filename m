From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 21 Jun 2016 11:32:52 +0200
Subject: [PATCH v2 2/2] Update ARM/TANGO section
In-Reply-To: <576908D6.8090000@sigmadesigns.com>
References: <576908D6.8090000@sigmadesigns.com>
Message-ID: <576909C4.208@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use regex pattern to match tango-specific files.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d174e34982b5..f3d920749bd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1748,8 +1748,7 @@ ARM/TANGO ARCHITECTURE
 M:	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
-F:	arch/arm/mach-tango/
-F:	arch/arm/boot/dts/tango*
+N:	tango
 
 ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
-- 
2.8.2
