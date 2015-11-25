From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2015 12:14:50 +0000
Subject: [PATCH] arm64: early_alloc: Fix check for allocation failure
In-Reply-To: <1448041540-26229-1-git-send-email-suzuki.poulose@arm.com>
References: <1448041540-26229-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151125121450.GD3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 05:45:40PM +0000, Suzuki K. Poulose wrote:
> In early_alloc we check if the memblock_alloc failed by checking
> the virtual address of the result, which will never fail. This patch
> fixes it to check the actual result for failure.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

Applied. Thanks.

-- 
Catalin
