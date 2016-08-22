From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 22 Aug 2016 12:36:30 +0200
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.8
In-Reply-To: <20160819160231.GH9893@arm.com>
References: <20160819160231.GH9893@arm.com>
Message-ID: <20160822103630.GK1437@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 05:02:31PM +0100, Will Deacon wrote:
> The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:
> 
>   Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes
> 
> for you to fetch changes up to 5bc0a11664e17e9f9551983f5b660bd48b57483c:
> 
>   iommu/arm-smmu: Don't BUG() if we find aborting STEs with disable_bypass (2016-08-19 09:48:15 +0100)
> 
> ----------------------------------------------------------------
> Robin Murphy (1):
>       iommu/io-pgtable-arm-v7s: Fix attributes when splitting blocks
> 
> Will Deacon (3):
>       iommu/arm-smmu: Fix CMDQ error handling
>       iommu/arm-smmu: Disable stalling faults for all endpoints
>       iommu/arm-smmu: Don't BUG() if we find aborting STEs with disable_bypass

Pulled, thanks Will.
