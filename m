From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 May 2013 14:43:37 +0100
Subject: [PATCH v8, part3 03/14] mm/ARM64: kill poison_init_mem()
In-Reply-To: <1369575522-26405-4-git-send-email-jiang.liu@huawei.com>
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com>
 <1369575522-26405-4-git-send-email-jiang.liu@huawei.com>
Message-ID: <20130528134336.GA15546@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 26, 2013 at 02:38:31PM +0100, Jiang Liu wrote:
> Use free_reserved_area() to poison initmem memory pages and kill
> poison_init_mem() on ARM64.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
