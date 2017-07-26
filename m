From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 26 Jul 2017 13:12:23 +0200
Subject: [PATCH 0/4] IOMMU group cleanup
In-Reply-To: <cover.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
Message-ID: <20170726111223.GO15833@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Fri, Jul 21, 2017 at 01:12:34PM +0100, Robin Murphy wrote:
> Robin Murphy (4):
>   iommu/msm: Add iommu_group support
>   iommu/tegra-smmu: Add iommu_group support
>   iommu/tegra-gart: Add iommu_group support
>   iommu: Finish making iommu_group support mandatory
> 
>  drivers/iommu/iommu.c      | 19 ++++---------------
>  drivers/iommu/msm_iommu.c  | 15 ++++++++++++++-
>  drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
>  drivers/iommu/tegra-smmu.c |  9 +++++++++
>  4 files changed, 46 insertions(+), 16 deletions(-)

Thanks for this series, much appreciated! I'll wait for the testing
results and apply them when all looks good.


Thanks,

	Joerg
