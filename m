From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 15 Oct 2015 17:04:43 +0200
Subject: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
In-Reply-To: <cover.1443718557.git.robin.murphy@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
Message-ID: <20151015150443.GA26332@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 08:13:57PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu: Implement common IOMMU ops for DMA mapping
>   arm64: Add IOMMU dma_ops
>   arm64: Hook up IOMMU dma_ops
> 
>  arch/arm64/Kconfig                   |   1 +
>  arch/arm64/include/asm/dma-mapping.h |  15 +-
>  arch/arm64/mm/dma-mapping.c          | 457 ++++++++++++++++++++++++++++++
>  drivers/iommu/Kconfig                |   7 +
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/dma-iommu.c            | 524 +++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h            |  85 ++++++
>  include/linux/iommu.h                |   1 +
>  8 files changed, 1083 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/iommu/dma-iommu.c
>  create mode 100644 include/linux/dma-iommu.h

Applied to the core branch.
