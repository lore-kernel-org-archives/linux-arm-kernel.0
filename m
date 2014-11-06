From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 6 Nov 2014 11:27:13 +0530
Subject: [PATCH v3 0/2] dmaengine: Add driver documentation
In-Reply-To: <1414529750-14431-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414529750-14431-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141106055713.GS1870@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 09:55:48PM +0100, Maxime Ripard wrote:
> Hi,
> 
> This is the third attempt at documenting how to write a dmaengine
> driver.

Applied all, thanks.

Fixed minor typos in second one.

Also we need to move dmatest.txt to new folder and also update MAINTAINERS,
so applied with these two patches as well

From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 6 Nov 2014 11:17:37 +0530
Subject: [PATCH 1/2] Documentation: dmanegine: move dmatest.txt to dmaengine folder

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 Documentation/{ => dmaengine}/dmatest.txt |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{ => dmaengine}/dmatest.txt (100%)

diff --git a/Documentation/dmatest.txt b/Documentation/dmaengine/dmatest.txt
similarity index 100%
rename from Documentation/dmatest.txt
rename to Documentation/dmaengine/dmatest.txt
-- 
1.7.0.4


From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 6 Nov 2014 11:21:17 +0530
Subject: [PATCH 2/2] MAINTAINERS: add Documentation files to dmaengine entry

We were missing the Documentation files in the entry so add it now. While at
it also remove comment on slave-dma for the tree

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 MAINTAINERS |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd3771c..b3f5493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3080,7 +3080,8 @@ Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
 S:	Maintained
 F:	drivers/dma/
 F:	include/linux/dma*
-T:	git git://git.infradead.org/users/vkoul/slave-dma.git (slave-dma)
+F:	Documentation/dmaengine/
+T:	git git://git.infradead.org/users/vkoul/slave-dma.git
 
 DME1737 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
-- 
1.7.0.4

-- 
~Vinod
