From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Aug 2013 16:34:53 +0900
Subject: [PATCH 00/07] ARM: shmobile: sh73a0, r8a7779 and emev2 SMP SCU
 rework
In-Reply-To: <20130731070702.14444.64961.sendpatchset@w520>
References: <20130731070702.14444.64961.sendpatchset@w520>
Message-ID: <20130801073452.GD26015@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 04:07:02PM +0900, Magnus Damm wrote:
> ARM: shmobile: sh73a0, r8a7779 and emev2 SMP SCU rework
> 
> [PATCH 01/07] ARM: shmobile: Introduce shared SCU SMP boot code
> [PATCH 02/07] ARM: shmobile: Use shared SCU SMP boot code on sh73a0
> [PATCH 03/07] ARM: shmobile: Use shared SCU SMP boot code on r8a7779
> [PATCH 04/07] ARM: shmobile: Use shared SCU SMP boot code on emev2
> [PATCH 05/07] ARM: shmobile: Add shared SCU CPU Hotplug code
> [PATCH 06/07] ARM: shmobile: Use shared SCU CPU Hotplug code on sh73a0
> [PATCH 07/07] ARM: shmobile: Use shared SCU CPU Hotplug code on r8a7779
> 
> This series consolidates mach-shmobile SMP code into SCU specific code
> for SMP boot and CPU Hotplug. The shared SCU code will in the future hook
> into some low level assembly code that provides SMP boot and sleep
> functionality, so this is is also preparations for future work.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git renesas-devel-20130731
>  
>  Requires "[PATCH] ARM: Fix memblock_reserve() to include stext" during
>  run time to allow test of CPU Hotplug with v3.11-rc kernels.

I guess we need to wait for Russell's alternate fix to hit a stable branch.
