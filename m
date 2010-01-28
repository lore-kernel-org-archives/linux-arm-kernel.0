From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 00:39:14 +0000
Subject: [PATCH 0/5] Arm Gic Changes
In-Reply-To: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <20100128003914.GM9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:32:24AM -0800, adharmap at codeaurora.org wrote:
> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> 
> Few fixes and improvements to arch/arm/common/gic.c file.

both ARM and GIC in the title should be all in capitals, they are
abbreviations of something longer.

I think it would be nicer to make GIC in all the patch titles all capital
instead of all lower case.
 
> Abhijeet Dharmapurikar (5):
>   gic: prevent gic from crossing NR_IRQ
>   gic: add callback for mask_ack
>   gic: Add set_type callback
>   gic: dont disable INT in ack callback
>   gic: initialize interrupts as per argument
> 
>  arch/arm/common/gic.c                    |  114 ++++++++++++++++++++++++-----
>  arch/arm/include/asm/hardware/gic.h      |    3 +-
>  arch/arm/mach-omap2/board-4430sdp.c      |    3 +-
>  arch/arm/mach-realview/realview_eb.c     |   10 ++-
>  arch/arm/mach-realview/realview_pb1176.c |    7 ++-
>  arch/arm/mach-realview/realview_pb11mp.c |    7 ++-
>  arch/arm/mach-realview/realview_pba8.c   |    4 +-
>  arch/arm/mach-realview/realview_pbx.c    |    5 +-
>  arch/arm/mach-ux500/cpu-u8500.c          |    2 +-
>  9 files changed, 122 insertions(+), 33 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
