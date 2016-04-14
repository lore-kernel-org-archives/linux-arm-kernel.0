From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Apr 2016 15:11:15 +0100
Subject: [PATCH v2 01/17] arm64: Reuse TCR field definitions for EL1 and
 EL2
In-Reply-To: <1460640065-27658-2-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570FA503.6040705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 14:20, Suzuki K Poulose wrote:
> TCR_EL1, TCR_EL2 and VTCR_EL2, all share some field positions
> (TG0, ORGN0, IRGN0 and SH0) and their corresponding value definitions.
> 
> This patch makes the TCR_EL1 definitions reusable and uses them for TCR_EL2
> and VTCR_EL2 fields.
> 
> This also fixes a bug where we assume TG0 in {V}TCR_EL2 is 1bit field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
