From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 25 Sep 2014 15:35:15 +0200
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.18
In-Reply-To: <20140922131810.GE25809@arm.com>
References: <20140922131810.GE25809@arm.com>
Message-ID: <20140925133515.GA28786@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 02:18:10PM +0100, Will Deacon wrote:
> Mitchel Humpherys (1):
>       iommu/arm-smmu: fix bug in pmd construction
> 
> Robin Murphy (2):
>       iommu/arm-smmu: fix architecture version detection
>       iommu/arm-smmu: support MMU-401
> 
> Will Deacon (5):
>       iommu/arm-smmu: allow translation stage to be forced on the cmdline
>       iommu/arm-smmu: add support for multi-master iommu groups
>       iommu/arm-smmu: put iommu_domain pointer in dev->archdata.iommu
>       iommu/arm-smmu: use page shift instead of page size to avoid division
>       iommu/arm-smmu: don't bother truncating the s1 output size to VA_BITS
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
>  drivers/iommu/arm-smmu.c                           | 201 ++++++++++++---------
>  2 files changed, 121 insertions(+), 81 deletions(-)

Pulled, thanks Will.
