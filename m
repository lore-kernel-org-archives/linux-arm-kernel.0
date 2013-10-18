From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Oct 2013 12:20:22 -0400
Subject: [PATCH] ARM: kirkwood: remove lagacy clk workarounds
In-Reply-To: <20131018161743.GA29595@localhost>
References: <1382097253-15624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131018144741.GL22434@titan.lakedaemon.net>
 <20131018161743.GA29595@localhost>
Message-ID: <20131018162022.GM22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 01:17:44PM -0300, Ezequiel Garcia wrote:
> On Fri, Oct 18, 2013 at 10:47:41AM -0400, Jason Cooper wrote:
> > On Fri, Oct 18, 2013 at 01:54:13PM +0200, Sebastian Hesselbarth wrote:
> > > With legacy devices converted to DT and a proper ethernet MAC
> > > workaround, we can now remove the clk workarounds for legacy
> > > devices. While at it, also cleanup the list of includes.
> > > 
> > > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > ---
> > > As a follow-up patch for latest mvebu PRs, this patch is based on
> > >  git://git.infradead.org/linux-mvebu.git tags/soc-3.13-2
> > > 
> > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: Russell King <linux@arm.linux.org.uk>
> > > Cc: Kevin Hilman <khilman@linaro.org>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: linux-kernel at vger.kernel.org
> > > ---
> > >  arch/arm/mach-kirkwood/board-dt.c |   42 ++----------------------------------
> > >  1 files changed, 3 insertions(+), 39 deletions(-)
> > 
> > Applied to mvebu/soc
> > 
> 
> Weird: I've tried to do this clean-up myself and my usual tests with network
> built as a module failed somehow. Maybe I missed something and did something
> stupid?
> 
> Of course, I'll re-try and let you all know...

Please do.  You can try mvebu/for-next now. It has this and everything
else we need to test for the merge window.

thx,

Jason.
