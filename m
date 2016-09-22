From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 22 Sep 2016 17:34:54 +0200
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.9
In-Reply-To: <20160920102534.GC17978@arm.com>
References: <20160920102534.GC17978@arm.com>
Message-ID: <20160922153454.GM3541@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 11:25:34AM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull these significant arm-smmu updates for 4.9. The vast majority
> of the code here is Robin's series to move the drivers over to the
> generic DT bindings, which finally hooks up the DMA API and MSI mapping
> for host machines. This has been stewing for a while and is now at the
> point where I feel it's much better in mainline than languishing outside.
> 
> A consequence of that is that there are some non-trivial changes outside
> of the drivers, but these are all acked by the relevant subsystem
> maintainers.
> 
> Other stuff here includes some non-critical fixes to the queue handling
> on SMMUv3 and a small devm cleanup that missed the boat last time around.
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:
> 
>   Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

Pulled, thanks Will.
