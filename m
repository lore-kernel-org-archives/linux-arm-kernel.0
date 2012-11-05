From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 5 Nov 2012 12:20:16 +0100
Subject: [PATCH 1/8] ARM: zynq: move arm-specific sys_timer out of ttc
In-Reply-To: <3ec3531d21c247ac3dcc76d91ff6be13ebfc733b.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <3ec3531d21c247ac3dcc76d91ff6be13ebfc733b.1351721190.git.josh.cartwright@ni.com>
Message-ID: <CAHTX3d+H7QOUgk8HxekEHd-=XV4k=pTbMcC_cAxkhj1z0s+TWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/31 Josh Cartwright <josh.cartwright@ni.com>:
> Move the sys_timer definition out of ttc driver and make it part of the
> common zynq code.  This is preparation for renaming and COMMON_CLK
> support.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/mach-zynq/common.c | 13 +++++++++++++
>  arch/arm/mach-zynq/common.h |  4 +---
>  arch/arm/mach-zynq/timer.c  | 10 +---------
>  3 files changed, 15 insertions(+), 12 deletions(-)
>

Tested-by: Michal Simek <michal.simek@xilinx.com>

Looks good to me. I have added it to my testing branch
and will provide path to mainline through xilinx arm-next branch

Thanks,
Michal
