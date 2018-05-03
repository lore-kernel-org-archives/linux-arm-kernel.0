From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 3 May 2018 15:31:45 +0200
Subject: [PATCH] iommu/io-pgtable-arm: Use for_each_set_bit to simplify
 code
In-Reply-To: <20180426044929.16896-1-yuehaibing@huawei.com>
References: <20180426044929.16896-1-yuehaibing@huawei.com>
Message-ID: <20180503133145.z6rpl3qd64tgfpm6@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 12:49:29PM +0800, YueHaibing wrote:
> We can use for_each_set_bit() to simplify code slightly in the
> ARM io-pgtable self tests while unmapping.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 5 +----
>  drivers/iommu/io-pgtable-arm.c     | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)

Applied, thanks.
