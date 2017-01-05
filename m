From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 17:18:24 +0000
Subject: [PATCH v3 3/9] arm64: cpufeature: Cleanup feature bit tables
In-Reply-To: <1483552147-9605-4-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170105171824.GE29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:49:01PM +0000, Suzuki K. Poulose wrote:
> This patch does the following clean ups :
> 
> 1) All undescribed fields of a register are now treated as "strict"
>    with a safe value of 0. Hence we could leave an empty table for
>    describing registers which are RAZ.
> 
> 2) ID_AA64DFR1_EL1 is RAZ and should use the table for RAZ register.
> 
> 3) ftr_generic32 is used to represent a register with a 32bit feature
>    value. Rename this to ftr_singl32 to make it more obvious. Since
>    we don't have a 64bit singe feature register, kill ftr_generic.

Nitpick: couple of "single" typos above.

> 
> Based on a patch by Mark Rutland.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
