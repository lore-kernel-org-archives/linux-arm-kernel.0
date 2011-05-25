From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 23:39:26 +0530
Subject: [PATCH] mainatiners: add dma engine tree details
Message-ID: <1306346966-16385-1-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f44130..4435893 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2169,6 +2169,8 @@ M:	Dan Williams <dan.j.williams@intel.com>
 S:	Supported
 F:	drivers/dma/
 F:	include/linux/dma*
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git
+T:	git git://git.infradead.org/users/vkoul/slave-dma.git (slave-dma)
 
 DME1737 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
-- 
1.7.0.4
