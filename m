From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Sep 2012 18:39:03 +0100
Subject: [PATCH v5 17/17] MAINTAINERS: add myself as Xen ARM maintainer
In-Reply-To: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
Message-ID: <1347903543-2135-17-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdc0119..3d38291 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7752,6 +7752,13 @@ F:	drivers/xen/
 F:	arch/x86/include/asm/xen/
 F:	include/xen/
 
+XEN HYPERVISOR ARM
+M:	Stefano Stabellini <stefano.stabellini@eu.citrix.com>
+L:	xen-devel at lists.xensource.com (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/xen/
+F:	arch/arm/include/asm/xen/
+
 XEN NETWORK BACKEND DRIVER
 M:	Ian Campbell <ian.campbell@citrix.com>
 L:	xen-devel at lists.xensource.com (moderated for non-subscribers)
-- 
1.7.2.5
