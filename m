From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 14:04:42 +0200
Subject: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings
 support
In-Reply-To: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160621120442.GH28248@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:06:01PM +0530, Sricharan R wrote:
> Sricharan R (6):
>   iommu/msm: Add DT adaptation
>   documentation: iommu: Add bindings for msm,iommu-v0 ip
>   iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
>   iommu/msm: Add support for generic master bindings
>   iommu/msm: use generic ARMV7S short descriptor pagetable ops
>   iommu/msm: Remove driver BROKEN
> 
>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
>  drivers/iommu/Kconfig                              |   2 +-
>  drivers/iommu/Makefile                             |   2 +-
>  drivers/iommu/msm_iommu.c                          | 870 +++++++++++----------
>  drivers/iommu/msm_iommu.h                          |  73 +-
>  drivers/iommu/msm_iommu_dev.c                      | 381 ---------
>  6 files changed, 564 insertions(+), 828 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  delete mode 100644 drivers/iommu/msm_iommu_dev.c

Applied this series, thanks.
