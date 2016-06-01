From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Jun 2016 09:16:41 +0100
Subject: [PATCH v5 04/18] arm64: Remove unnecessary of_platform_populate
 with default match table
In-Reply-To: <1464763991-26634-5-git-send-email-wangkefeng.wang@huawei.com>
References: <1464763991-26634-1-git-send-email-wangkefeng.wang@huawei.com>
 <1464763991-26634-5-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160601081640.GA23375@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 02:52:57PM +0800, Kefeng Wang wrote:
> After patch "of/platform: Add common method to populate default bus",
> it is possible for arch code to remove unnecessary callers of
> of_platform_populate with default match table.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
