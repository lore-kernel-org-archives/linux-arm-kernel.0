From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jun 2016 17:55:42 +0100
Subject: [PATCH] arm64: mm: remove unnecessary BUG_ON
In-Reply-To: <1467252124-19625-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1467252124-19625-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160630165542.GD26679@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 10:02:04AM +0800, Kefeng Wang wrote:
> The memblock_alloc() and memblock_alloc_base() will panic on their own
> if no free memory, remove pointless BUG_ON.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied. Thanks.

-- 
Catalin
