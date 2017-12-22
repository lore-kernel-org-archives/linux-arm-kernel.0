From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Dec 2017 15:43:34 +0000
Subject: [PATCH v2 8/8] arm64: enable 52-bit physical address support
In-Reply-To: <20171222152307.11252-9-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-9-catalin.marinas@arm.com>
Message-ID: <1d2ec5be-9b7b-c6a2-27b2-8ebdc0d6095f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:23, Catalin Marinas wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> Now that 52-bit physical address support is in place, add the kconfig
> symbol to enable it. As described in ARMv8.2, the larger addresses are
> only supported with the 64k granule. Also ensure that PAN is configured
> (or TTBR0 PAN is not), as explained in an earlier patch in this series.
> 
> Tested-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
