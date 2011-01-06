From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 6 Jan 2011 14:02:02 +0900
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTi=qtRP1tAs1wPnGugE2rGBTERgHuUKKBWhbs=ST@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 5:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/include/asm/memory.h ? ? ? ? ? ? ? ? ?| ? ?2 ++
> ?arch/arm/kernel/tcm.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
...
> ?arch/arm/mach-shmobile/include/mach/memory.h ? | ? ?2 +-

Applied on top of sh-2.6 git c422a5992e9ca072e8e472ee8f518649fb07470e
and successfully booted on a sh7372-based Mackerel board.

Acked-by: Magnus Damm <damm@opensource.se>
