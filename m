From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:09:29 +0900
Subject: [PATCH 00/02] ARM: shmobile: romImage update
In-Reply-To: <20130605075514.17653.77135.sendpatchset@w520>
References: <20130605075514.17653.77135.sendpatchset@w520>
Message-ID: <20130612140928.GP32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 04:55:14PM +0900, Magnus Damm wrote:
> ARM: shmobile: romImage update
> 
> [PATCH 01/02] ARM: shmobile: Let romImage rely on default ATAGS
> [PATCH 02/02] ARM: shmobile: Remove romImage CONFIG_MEMORY_START
> 
> Rework the mach-shmobile romImage code to remove memory configuration
> kept in the kernel configuration.
> 
> This is one of several series of code that reworks code not to rely on
> CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas.git renesas-next-20130604v2
> 
>  arch/arm/boot/compressed/head-shmobile.S    |   21 ++-------------------
>  arch/arm/mach-shmobile/include/mach/zboot.h |    2 ++
>  2 files changed, 4 insertions(+), 19 deletions(-)

Thanks, I have queued this up in the soc2 branch for v3.11.
