From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 2 Mar 2016 14:49:21 +0100
Subject: [PATCH v2] iommu/io-pgtable-armv7s: Fix kmem_cache_alloc() flags
In-Reply-To: <526555051e63e72a4b1e68461e51a7b6e33df352.1456859025.git.robin.murphy@arm.com>
References: <526555051e63e72a4b1e68461e51a7b6e33df352.1456859025.git.robin.murphy@arm.com>
Message-ID: <20160302134921.GB20213@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2016 at 07:07:03PM +0000, Robin Murphy wrote:
> v2: Add the backtrace to the commit log, add Will's ack.
>  
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
