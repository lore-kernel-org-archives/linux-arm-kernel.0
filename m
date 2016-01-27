From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Jan 2016 10:38:20 +0000
Subject: [PATCH 02/15] arm64: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453868872-26300-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-3-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160127103820.GH14823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 12:27:39PM +0800, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
