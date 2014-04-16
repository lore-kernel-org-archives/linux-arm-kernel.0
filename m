From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 16 Apr 2014 15:35:16 +0200
Subject: [GIT PULL] iommu/arm-smmu: fixes for 3.15
In-Reply-To: <20140415162106.GN17408@arm.com>
References: <20140415162106.GN17408@arm.com>
Message-ID: <20140416133516.GA3577@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:21:06PM +0100, Will Deacon wrote:
> --->8
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes
> 
> for you to fetch changes up to aca1bc4595c5757f01167ab5bfef2a4f8edfcf4f:
> 
>   iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte (2014-04-15 12:23:11 +0100)
> 
> ----------------------------------------------------------------
> Bin Wang (1):
>       iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte
> 
> Laurent Pinchart (1):
>       iommu/arm-smmu: Return 0 on unmap failure
> 
>  drivers/iommu/arm-smmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pulled, thanks Will.
