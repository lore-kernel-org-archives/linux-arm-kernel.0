From: tony@atomide.com (Tony Lindgren)
Date: Sat, 30 Nov 2013 09:29:59 -0800
Subject: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot
 in DT only mode
In-Reply-To: <CABxcv==NQpKN4evq3ufgo7EGeLuXphgRjz3WXHeBsnKX5qMvHg@mail.gmail.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <CABxcv==NQpKN4evq3ufgo7EGeLuXphgRjz3WXHeBsnKX5qMvHg@mail.gmail.com>
Message-ID: <20131130172959.GF23334@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [131129 11:13]:
> 
> I just tested your branch on my DM3730 IGEPv2 board and everything
> works correctly.

OK good to hear.
 
> Also, I noticed that there are some remaining code that is unused now
> that the board files are gone and can be removed.
> 
> I'll send now as a separate series but the diffstat is
> 
>  arch/arm/mach-omap2/Makefile        |   9 -----
>  arch/arm/mach-omap2/board-flash.c   | 245
> ----------------------------------------------------------------------------------------------------------------------------
>  arch/arm/mach-omap2/board-flash.h   |  62 --------------------------------
>  arch/arm/mach-omap2/gpmc-smc91x.c   | 186
> ----------------------------------------------------------------------------------------------
>  arch/arm/mach-omap2/gpmc-smc91x.h   |  42 ----------------------
>  arch/arm/mach-omap2/gpmc-smsc911x.c | 100
> ---------------------------------------------------
>  arch/arm/mach-omap2/gpmc-smsc911x.h |  35 ------------------
>  arch/arm/mach-omap2/gpmc.c          |   1 -
>  8 files changed, 680 deletions(-)

Yeah great, saw that, will look at it more on Monday.

Regards,

Tony
