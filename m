From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 5 Jun 2013 18:02:07 +0100
Subject: [PATCH v4 6/6] MAINTAINERS: add myself as arm64/xen maintainer
In-Reply-To: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
Message-ID: <1370451727-26826-6-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Ian Campbell <ian.campbell@citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd3a495..95a6a51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9096,6 +9096,13 @@ S:	Supported
 F:	arch/arm/xen/
 F:	arch/arm/include/asm/xen/
 
+XEN HYPERVISOR ARM64
+M:	Stefano Stabellini <stefano.stabellini@eu.citrix.com>
+L:	xen-devel at lists.xensource.com (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm64/xen/
+F:	arch/arm64/include/asm/xen/
+
 XEN NETWORK BACKEND DRIVER
 M:	Ian Campbell <ian.campbell@citrix.com>
 L:	xen-devel at lists.xensource.com (moderated for non-subscribers)
-- 
1.7.2.5
