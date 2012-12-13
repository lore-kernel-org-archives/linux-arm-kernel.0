From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 13 Dec 2012 14:03:36 +0100
Subject: [PATCH 1/1] net: cpts: fix for build break after ARM SoC
 integration
In-Reply-To: <50C9B6F9.9020300@iki.fi>
References: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
 <50C9B6F9.9020300@iki.fi>
Message-ID: <20121213130335.GA10703@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 01:07:37PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 2012-11-27 12:27, Mugunthan V N wrote:
> >   CC      drivers/net/ethernet/ti/cpts.o
> > drivers/net/ethernet/ti/cpts.c:30:24: fatal error: plat/clock.h: No such file or directory
> > compilation terminated.
> > make[4]: *** [drivers/net/ethernet/ti/cpts.o] Error 1
> > make[3]: *** [drivers/net/ethernet/ti] Error 2
> > make[2]: *** [drivers/net/ethernet] Error 2
> > make[1]: *** [drivers/net] Error 2
> > 
> > fix for build break as the header file is removed from plat-omap as part of
> > the below patch
> 
> linux-next still has this build problem, I guess this patch is lingering
> somewhere. Somewhat annoying, as the driver is enabled by default. (btw,
> why is it "default y"?)

Um, in Linus' master, net, and net-next, neither TI_CPSW nor TI_CPTS
are default y, so I don't know where you are coming from on that.

Sorry,
Richard
