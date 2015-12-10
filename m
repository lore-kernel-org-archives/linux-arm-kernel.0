From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Dec 2015 08:45:09 +0530
Subject: [GIT PULL for 4.4] DT/dmaengine: edma: Update for the new bindings
In-Reply-To: <56680C1A.3050009@ti.com>
References: <56680C1A.3050009@ti.com>
Message-ID: <20151210031509.GI1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 01:10:18PM +0200, Peter Ujfalusi wrote:
> Hi Arnd, Vinod,
> 
> As Arnd suggested, the two patch from the following series:
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg122201.html
> 
> plus Acked-by from Arnd is available for pull if you prefer that way.

Sorry saw this after I pushed out the fixes/edma..

> 
> 
> Regards,
> P?ter
> ================================================================
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/omap-audio/linux-audio.git for-4.4/peter/edma_binding_update
> 
> for you to fetch changes up to af9089852e0ecd6ae7336992d29b04d7d82b404a:
> 
>   dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit type (2015-12-09 11:56:56 +0200)
> 
> ----------------------------------------------------------------
> Peter Ujfalusi (2):
>       dmaengine: edma: DT: Change memcpy channel array from 16bit to 32bit type
>       dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit type
> 
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 10 ++++------
>  drivers/dma/edma.c                                | 53 +++++++++++++++++++++++++++++++++++------------------
>  include/linux/platform_data/edma.h                |  2 +-
>  3 files changed, 40 insertions(+), 25 deletions(-)

-- 
~Vinod
