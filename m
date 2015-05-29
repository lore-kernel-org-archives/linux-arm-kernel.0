From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 11:15:37 +0200
Subject: [PATCH v2 0/3] iommu/arm=smmu: Add driver for ARM SMMUv3 devices
In-Reply-To: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
References: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150529091537.GH13130@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 05:25:57PM +0100, Will Deacon wrote:
> Will Deacon (3):
>   Documentation: dt-bindings: Add device-tree binding for ARM SMMUv3
>     IOMMU
>   iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices
>   drivers/vfio: Allow type-1 IOMMU instantiation on top of an ARM SMMUv3
> 
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   37 +
>  MAINTAINERS                                        |    3 +-
>  drivers/iommu/Kconfig                              |   13 +
>  drivers/iommu/Makefile                             |    1 +
>  drivers/iommu/arm-smmu-v3.c                        | 2670 ++++++++++++++++++++
>  drivers/vfio/Kconfig                               |    2 +-
>  6 files changed, 2724 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>  create mode 100644 drivers/iommu/arm-smmu-v3.c

Applied, thanks.
