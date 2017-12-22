From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Dec 2017 15:34:26 +0000
Subject: [PATCH v2 4/8] arm64: head.S: handle 52-bit PAs in PTEs in early
 page table setup
In-Reply-To: <20171222152307.11252-5-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-5-catalin.marinas@arm.com>
Message-ID: <666dc312-6847-c604-ca92-138d4ab9cad3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:23, Catalin Marinas wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> The top 4 bits of a 52-bit physical address are positioned at bits
> 12..15 in page table entries. Introduce a macro to move the bits there,
> and change the early ID map and swapper table setup code to use it.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> [catalin.marinas at arm.com: additional comments for clarification]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
