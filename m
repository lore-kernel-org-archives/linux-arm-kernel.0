From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 4 Aug 2017 11:59:59 +0200
Subject: [PATCH 0/2] iommu/omap: Rework cache functionality with DMA
 Streaming API
In-Reply-To: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
References: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
Message-ID: <20170804095959.GB17443@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 03:49:12PM -0500, Josue Albarran wrote:
> Fernando Guzman Lugo (1):
>   iommu/omap: Fix disabling of MMU upon a fault
> 
> Josue Albarran (1):
>   iommu/omap: Use DMA-API for performing cache flushes
> 
>  drivers/iommu/omap-iommu.c | 125 +++++++++++++++++++++++++++++----------------
>  drivers/iommu/omap-iommu.h |   1 +
>  2 files changed, 81 insertions(+), 45 deletions(-)

Applied, thanks.
