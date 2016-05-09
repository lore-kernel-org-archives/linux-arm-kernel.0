From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 9 May 2016 12:06:15 +0200
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.7
In-Reply-To: <20160504134531.GA31744@arm.com>
References: <20160504134531.GA31744@arm.com>
Message-ID: <20160509100615.GE9801@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2016 at 02:45:31PM +0100, Will Deacon wrote:
> Peng Fan (1):
>       iommu/arm-smmu: Clear cache lock bit of ACR
> 
> Robin Murphy (7):
>       iommu/arm-smmu: Differentiate specific implementations
>       iommu/arm-smmu: Convert ThunderX workaround to new method
>       iommu/arm-smmu: Work around MMU-500 prefetch errata
>       io-64-nonatomic: Add relaxed accessor variants
>       iommu/arm-smmu: Tidy up 64-bit/atomic I/O accesses
>       iommu/arm-smmu: Decouple context format from kernel config
>       iommu/arm-smmu: Support SMMUv1 64KB supplement
> 
> Tirumalesh Chalamarla (2):
>       iommu/arm-smmu: Add support for 16 bit VMID
>       iommu/arm-smmu: Workaround for ThunderX erratum #27704
> 
>  Documentation/arm64/silicon-errata.txt             |   2 +
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
>  drivers/iommu/arm-smmu.c                           | 291 +++++++++++++++------
>  include/asm-generic/io.h                           |   4 +-
>  include/linux/io-64-nonatomic-hi-lo.h              |  25 ++
>  include/linux/io-64-nonatomic-lo-hi.h              |  25 ++
>  6 files changed, 265 insertions(+), 83 deletions(-)

Pulled, thanks Will.
