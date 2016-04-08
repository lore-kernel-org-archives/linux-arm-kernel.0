From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 14:43:39 +0200
Subject: [PATCH 01/17] arm64: Reuse TCR field definitions for EL1 and EL2
In-Reply-To: <1459787177-12767-2-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160408124339.GM8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 05:26:01PM +0100, Suzuki K Poulose wrote:
> TCR_EL1, TCR_EL2 and VTCR_EL2, all share some field positions
> (TG0, ORGN0, IRGN0 and SH0) and their corresponding value definitions.
> 
> This patch makes the TCR_EL1 definitions reusable and uses them for TCR_EL2
> and VTCR_EL2 fields.
> 
> This also fixes a bug where TG0 in {V}TCR_EL2 was treated as 1bit field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
