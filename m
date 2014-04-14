From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Apr 2014 17:57:37 +0100
Subject: [PULL] fix for ARM SMMU driver
In-Reply-To: <53453EF9.8020704@arm.com>
References: <53453EF9.8020704@arm.com>
Message-ID: <20140414165737.GH12916@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I'm back at my desk now, catching up on email.

On Wed, Apr 09, 2014 at 01:37:13PM +0100, Marc Zyngier wrote:
> Joerg,
> 
> Please consider pulling the following branch, which contains the fix 
> for a bug affecting the ARM SMMU driver.

Joerg, if you haven't pulled this yet (I can't see it in your tree), please
can you hold off? There's another fix pending from Laurent Pinchart, so I
was planning to send them as a single pull once they've passed my testing.

Cheers,

Will

> The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:
> 
>   Linux 3.14 (2014-03-30 20:40:15 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git arm/smmu-fixes-3.15
> 
> for you to fetch changes up to a1b10277530d4df09feffe9243f766aef945684e:
> 
>   iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte (2014-04-09 13:28:58 +0100)
> 
> ----------------------------------------------------------------
> Bin Wang (1):
>       iommu/arm-smmu: fix panic in arm_smmu_alloc_init_pte
> 
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
