From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 31 Mar 2015 15:40:12 +0200
Subject: [GIT PULL] iommu/arm-smmu: updates for 4.1
In-Reply-To: <20150327172146.GM1562@arm.com>
References: <20150327172146.GM1562@arm.com>
Message-ID: <20150331134012.GC22683@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 05:21:46PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

Pulled, but ...

> Robin Murphy (1):
>       iommu/arm-smmu: set a more appropriate DMA mask
> 
> Will Deacon (3):
>       iommu/arm-smmu: ensure CBA2R is initialised before CBAR on SMMUv2
>       iommu/arm-smmu: handle multi-alias IOMMU groups for PCI devices
>       iommu/io-pgtable-arm: avoid speculative walks through TTBR1

... next time please make sure the commit subjects start with capital
letters after the colon.

Thanks,

	Joerg
