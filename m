From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jan 2016 18:28:58 +0000
Subject: [PATCH v2 2/3] iommu/io-pgtable: Add helper functions for TLB ops
In-Reply-To: <a2a13711c528af068e932ce6af4c3be50bef5812.1450383740.git.robin.murphy@arm.com>
References: <cover.1450383740.git.robin.murphy@arm.com>
 <a2a13711c528af068e932ce6af4c3be50bef5812.1450383740.git.robin.murphy@arm.com>
Message-ID: <20160112182857.GD22186@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 08:50:58PM +0000, Robin Murphy wrote:
> Add some simple wrappers to avoid having the guts of the TLB operations
> spilled all over the page table implementations, and to provide a point
> to implement extra common functionality.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 48 ++++++++++++++++----------------------
>  drivers/iommu/io-pgtable-arm.c     | 21 +++++++----------
>  drivers/iommu/io-pgtable.c         |  2 +-
>  drivers/iommu/io-pgtable.h         | 16 +++++++++++++
>  4 files changed, 46 insertions(+), 41 deletions(-)

Looks sensible to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

I'd like to see a review from Yong Wu on the short descriptor stuff
before I queue any of this, though.

Will
