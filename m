From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 12:44:45 +0100
Subject: [PATCHv3 04/19] arm64: kill config_sctlr_el1()
In-Reply-To: <20180618120310.39527-5-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-5-mark.rutland@arm.com>
Message-ID: <20180619114445.w5mje7n3jsaflzhl@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:55PM +0100, Mark Rutland wrote:
> Now that we have sysreg_clear_set(), we can consistently use this
> instead of config_sctlr_el1().
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
