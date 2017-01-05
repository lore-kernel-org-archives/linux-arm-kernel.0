From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 17:26:24 +0000
Subject: [PATCH v3 5/9] arm64: cpufeature: Define helpers for sys_reg id
In-Reply-To: <1483552147-9605-6-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170105172624.GF29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:49:03PM +0000, Suzuki K. Poulose wrote:
> Define helper macros to extract op0, op1, CRn, CRm & op2
> for a given sys_reg id. While at it remove the explicit
> masking only used for Op0.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
