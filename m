From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 14:29:55 +0100
Subject: [PATCH v4 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <1461324335-5081-2-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
 <1461324335-5081-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160422132955.GI2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:25:31PM +0100, Suzuki K. Poulose wrote:
> Add scope parameter to the arm64_cpu_capabilities::matches(), so that
> this can be reused for checking the capability on a given CPU vs the
> system wide. The system uses the default scope associated with the
> capability for initialising the CPU_HWCAPs and ELF_HWCAPs.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

In case Will hasn't queued the patches yet:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
