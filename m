From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Jun 2012 03:28:42 -0700
Subject: [PATCH] ARM: omap4: Fix standalone OMAP4 build break
In-Reply-To: <20120625105336.GD12766@atomide.com>
References: <1340365461-25385-1-git-send-email-rnayak@ti.com>
 <20120625105336.GD12766@atomide.com>
Message-ID: <20120626102842.GB31393@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120625 03:58]:
> * Rajendra Nayak <rnayak@ti.com> [120622 04:48]:
> > Fix the below build error while building OMAP4 standalone
> > 
> >   CC      arch/arm/mach-omap2/board-flash.o
> > arch/arm/mach-omap2/board-flash.c:102: error: redefinition of 'board_onenand_init'
> > arch/arm/mach-omap2/board-flash.h:56: note: previous definition of 'board_onenand_init' was here
> > make[1]: *** [arch/arm/mach-omap2/board-flash.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Thanks, applying into fixes with the updated description to describe
> the regression causing commit.

Oops, looks like I have an earlier fix already in fixes-board branch
from Kevin that I'll use instead.

Regards,

Tony
