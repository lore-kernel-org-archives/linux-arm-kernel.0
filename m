From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 15:31:24 +0100
Subject: [PATCH v2 09/17] kvm-arm: arm64: Introduce stage2 page table
 helpers
In-Reply-To: <1460640065-27658-10-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570FA9BC.8020001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> Introduce stage2 page table helpers for arm64. With the fake
> page table level still in place, the stage2 table has the same
> number of levels as that of the host (and hyp), so they all
> fallback to the host version.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
