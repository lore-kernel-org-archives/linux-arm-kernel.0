From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 17 Jun 2013 07:16:22 +0200
Subject: [PATCH] ARM: dma-mapping: Get pages if the cpu_addr is out of
 atomic_pool
In-Reply-To: <1371442732-15088-1-git-send-email-yj44.cho@samsung.com>
References: <1371442732-15088-1-git-send-email-yj44.cho@samsung.com>
Message-ID: <20130617.081622.332935718957738769.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

YoungJun Cho <yj44.cho@samsung.com> wrote @ Mon, 17 Jun 2013 06:18:52 +0200:

> In __iommu_get_pages(), the cpu_addr is checked wheather in
> atomic_pool range or not. So if the cpu_addr is in atomic_pool
> range, it does not need to check twice.
> 
> Signed-off-by: YoungJun Cho <yj44.cho@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Looks ok to me, at least.
