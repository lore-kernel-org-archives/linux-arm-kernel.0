From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 31 Mar 2017 15:46:04 +0100
Subject: [PATCH RESEND 0/3] IOVA allocation improvements for iommu-dma
Message-ID: <cover.1490971180.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Here's the series rebased onto your current next branch just for the
sake of it, and with the tags added. No other changes.

Thanks,
Robin.

Robin Murphy (3):
  iommu/dma: Convert to address-based allocation
  iommu/dma: Clean up MSI IOVA allocation
  iommu/dma: Plumb in the per-CPU IOVA caches

 drivers/iommu/dma-iommu.c | 176 ++++++++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 86 deletions(-)

-- 
2.11.0.dirty
