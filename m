From: davem@davemloft.net (David Miller)
Date: Sun, 22 Jul 2018 20:52:19 -0700 (PDT)
Subject: [PATCH v2 net-next] net: mediatek: use dma_zalloc_coherent
 instead of allocator/memset
In-Reply-To: <20180723031647.9820-1-yuehaibing@huawei.com>
References: <20180723031647.9820-1-yuehaibing@huawei.com>
Message-ID: <20180722.205219.971856341700917090.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 23 Jul 2018 11:16:47 +0800

> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: remove redundant __GFP_ZERO

Applied, thank you.
