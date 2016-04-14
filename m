From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 15:14:11 +0100
Subject: [PATCH v2 04/17] arm64: Introduce pmd_thp_or_huge
In-Reply-To: <1460640065-27658-5-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570FA5B3.4090804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> Add a helper to determine if a given pmd represents a huge page
> either by hugetlb or thp, as we have for arm. This will be used
> by KVM MMU code.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
