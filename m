From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 4 Mar 2014 14:58:29 +0100
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.15
In-Reply-To: <20140228110525.GA674@mudshark.cambridge.arm.com>
References: <20140228110525.GA674@mudshark.cambridge.arm.com>
Message-ID: <20140304135829.GA2799@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 11:05:25AM +0000, Will Deacon wrote:
> The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:
> 
>   Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates
> 
> for you to fetch changes up to 34fb4b37b7b6da7dc34797d1abf234dd30b091d8:
> 
>   iommu/arm-smmu: fix incorrect comment regarding TLB invalidation (2014-02-27 19:08:43 +0000)
> 
> ----------------------------------------------------------------
> Andreas Herrmann (3):
>       iommu/arm-smmu: set MAX_MASTER_STREAMIDS to MAX_PHANDLE_ARGS
>       iommu/arm-smmu: support buggy implementations with secure cfg accesses
>       documentation/iommu: update description of ARM System MMU binding
> 
> Will Deacon (3):
>       iommu/arm-smmu: clean up use of `flags' in page table handling code
>       iommu/arm-smmu: provide option to dsb macro when publishing tables
>       iommu/arm-smmu: fix incorrect comment regarding TLB invalidation
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   6 ++
>  drivers/iommu/arm-smmu.c                           | 105 ++++++++++++++-------
>  2 files changed, 77 insertions(+), 34 deletions(-)

Pulled, thanks Will.
