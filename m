From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Jan 2015 10:59:39 +0900
Subject: [PATCH 00/03] ARM: shmobile: Minor header cleanup
In-Reply-To: <20150120115750.11479.95109.sendpatchset@little-apple>
References: <20150120115750.11479.95109.sendpatchset@little-apple>
Message-ID: <20150121015937.GD30598@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 08:57:50PM +0900, Magnus Damm wrote:
> ARM: shmobile: Minor header cleanup
> 
> [PATCH 01/03] ARM: shmobile: Remove mach/system.h
> [PATCH 02/03] ARM: shmobile: Remove mach/clkdev.h
> [PATCH 03/03] ARM: shmobile: Remove mach/uncompress.h
> 
> Rework the mach-shmobile code a bit more to allow
> removing the files system.h, clkdev.h and uncompress.h
> from arch/arm/mach-shmobile/include/mach/
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up for v3.21 with Laurent and Geert's Acks.

> ---
> 
>  Built on top of renesas-devel-20150119-v3.19-rc5
> 
>  arch/arm/Kconfig                                 |    1 -
>  arch/arm/Kconfig.debug                           |    3 ++-
>  arch/arm/mach-shmobile/clock.c                   |   11 -----------
>  arch/arm/mach-shmobile/include/mach/clkdev.h     |    7 -------
>  arch/arm/mach-shmobile/include/mach/system.h     |   11 -----------
>  arch/arm/mach-shmobile/include/mach/uncompress.h |   19 -------------------
>  6 files changed, 2 insertions(+), 50 deletions(-)
> 
