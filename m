From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 6 Mar 2017 15:11:34 +0900
Subject: [PATCH] MAINTAINERS: Remove self from Tegra maintainers
Message-ID: <20170306061134.21105-1-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have not been doing any Tegra maintainance work for a while, and this
is unlikely to change in the foreseeable future. Better reflect the
actual state of things by removing myself from the list.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0b731047263..6894d47de8c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12313,7 +12313,6 @@ F:	drivers/media/rc/ttusbir.c
 
 TEGRA ARCHITECTURE SUPPORT
 M:	Thierry Reding <thierry.reding@gmail.com>
-M:	Alexandre Courbot <gnurou@gmail.com>
 M:	Jonathan Hunter <jonathanh@nvidia.com>
 L:	linux-tegra at vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
-- 
2.12.0
