From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Dec 2017 15:30:55 +0000
Subject: [PATCH v2 1/8] arm64: add kconfig symbol to configure physical
 address size
In-Reply-To: <20171222152307.11252-2-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-2-catalin.marinas@arm.com>
Message-ID: <4982e645-ac6d-90dc-8dd3-ed1156015434@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:23, Catalin Marinas wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> ARMv8.2 introduces support for 52-bit physical addresses. To prepare for
> supporting this, add a new kconfig symbol to configure the physical
> address space size. The symbols will be used in subsequent patches.
> Currently the only choice is 48, a later patch will add the option of 52
> once the required code is in place.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> [catalin.marinas at arm.com: folded minor patches into this one]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
