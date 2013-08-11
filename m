From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 11 Aug 2013 15:52:32 -0400
Subject: [PATCH 0/4] mtd: gpmi: support two nand chips at most
In-Reply-To: <20130811060921.GB16906@norris.computersforpeace.net>
References: <1371197185-27491-1-git-send-email-b32955@freescale.com>
 <20130811060921.GB16906@norris.computersforpeace.net>
Message-ID: <20130811195230.GA28172@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 11:09:21PM -0700, Brian Norris wrote:
> On Fri, Jun 14, 2013 at 04:06:21PM +0800, Huang Shijie wrote:
> > 
> >  drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   14 ++++++++++++++
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    7 +++----
> >  drivers/mtd/nand/gpmi-nand/gpmi-regs.h |    3 +++
> >  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> What's the status on this patch set? It doesn't look like it got merged.
> Do you have any testing for this? It looks sane enough to me.

Please ignore this patch set. I find a better solution to fix this
issue. I will send a new version of this patch set when it is ready.


thanks
Huang Shijie
