From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 30 Dec 2013 14:19:15 +0100
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.14
In-Reply-To: <20131217180854.GG349@mudshark.cambridge.arm.com>
References: <20131217180854.GG349@mudshark.cambridge.arm.com>
Message-ID: <20131230131914.GA2799@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 06:08:54PM +0000, Will Deacon wrote:
> Antonios Motakis (1):
>       iommu/arm-smmu: add devices attached to the SMMU to an IOMMU group
> 
> Will Deacon (3):
>       iommu/arm-smmu: use VA_BITS to determine arm64 virtual address space
>       iommu: add IOMMU_EXEC flag for safely allowing XN mappings
>       iommu/arm-smmu: add support for IOMMU_EXEC
> 
>  drivers/iommu/arm-smmu.c | 33 ++++++++++++++++++++++++++-------
>  include/linux/iommu.h    |  7 ++++---
>  2 files changed, 30 insertions(+), 10 deletions(-)

Pulled, thanks Will.
