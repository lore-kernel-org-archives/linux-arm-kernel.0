From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Mar 2016 12:10:20 +0000
Subject: [PATCH] arm64: drop unused __local_flush_icache_all()
In-Reply-To: <1458035230-1038-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1458035230-1038-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160321121019.GD25466@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 05:47:10PM +0800, Kefeng Wang wrote:
> After commit 65da0a8e34a8 ("arm64: use non-global mappings for UEFI
> runtime regions"), nobody use __local_flush_icache_all() anymore,
> so drop it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied. Thanks.

-- 
Catalin
