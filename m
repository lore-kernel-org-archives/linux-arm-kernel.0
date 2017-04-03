From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 3 Apr 2017 12:45:33 +0200
Subject: [PATCH RESEND 0/3] IOVA allocation improvements for iommu-dma
In-Reply-To: <cover.1490971180.git.robin.murphy@arm.com>
References: <cover.1490971180.git.robin.murphy@arm.com>
Message-ID: <20170403104532.GA4683@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 03:46:04PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu/dma: Convert to address-based allocation
>   iommu/dma: Clean up MSI IOVA allocation
>   iommu/dma: Plumb in the per-CPU IOVA caches
> 
>  drivers/iommu/dma-iommu.c | 176 ++++++++++++++++++++++++----------------------
>  1 file changed, 90 insertions(+), 86 deletions(-)

Applied to arm/core, thanks Robin.
