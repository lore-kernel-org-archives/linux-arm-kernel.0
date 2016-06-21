From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jun 2016 16:14:05 +0100
Subject: [PATCH] arm64: Add support ARCH_SUPPORTS_INT128
In-Reply-To: <1466492123-3356-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1466492123-3356-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160621151404.GD14542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 02:55:23PM +0800, Kefeng Wang wrote:
> The gcc support __SIZEOF_INT128__ and __int128 in arm64, thus,
> enable ARCH_SUPPORTS_INT128 to make mul_u64_u32_shr() a bit
> more efficient in scheduler.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Queued for 4.8. Thanks.

-- 
Catalin
