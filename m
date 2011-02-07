From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 7 Feb 2011 17:36:04 +0100
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <20110207163604.GJ26656@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:22 Tue 04 Jan     , Russell King - ARM Linux wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/memory.h                  |    2 ++
>  arch/arm/kernel/tcm.c                          |    2 +-
>  arch/arm/mach-aaec2000/include/mach/memory.h   |    2 +-
>  arch/arm/mach-at91/include/mach/memory.h       |    2 +-
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
