From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 29 May 2018 17:03:55 +0200
Subject: [PATCH v2] iommu/io-pgtable-arm: Make allocations NUMA-aware
In-Reply-To: <b420b4733b5bc939931c11ee573bbb598f72e7b0.1526989635.git.robin.murphy@arm.com>
References: <b420b4733b5bc939931c11ee573bbb598f72e7b0.1526989635.git.robin.murphy@arm.com>
Message-ID: <20180529150355.nn6embgvyx2crkba@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 12:50:09PM +0100, Robin Murphy wrote:
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Retain equivalent highmem check
> 
>  drivers/iommu/io-pgtable-arm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.
