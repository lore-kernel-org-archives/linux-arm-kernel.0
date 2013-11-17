From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 17 Nov 2013 01:52:53 -0300
Subject: [PATCH v2 1/4] clk: mvebu: Add Core Divider clock
In-Reply-To: <20131022095317.11944.60429@quantum>
References: <1380224130-11868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380224130-11868-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131002174332.GQ31178@titan.lakedaemon.net>
 <20131002180944.GC2365@localhost> <20131008195933.GA2473@localhost>
 <20131016110819.GC2518@localhost> <20131017191852.GA8832@localhost>
 <20131017192545.GJ22434@titan.lakedaemon.net>
 <20131022095317.11944.60429@quantum>
Message-ID: <20131117045252.GA2677@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Oct 22, 2013 at 02:53:17AM -0700, Mike Turquette wrote:
> Quoting Jason Cooper (2013-10-17 12:25:45)
> > On Thu, Oct 17, 2013 at 04:18:53PM -0300, Ezequiel Garcia wrote:
> > > On Wed, Oct 16, 2013 at 08:08:19AM -0300, Ezequiel Garcia wrote:
> > > > On Tue, Oct 08, 2013 at 04:59:33PM -0300, Ezequiel Garcia wrote:
> > > > > On Wed, Oct 02, 2013 at 03:09:44PM -0300, Ezequiel Garcia wrote:
> > > > > > On Wed, Oct 02, 2013 at 01:43:32PM -0400, Jason Cooper wrote:
> > > > > > > On Thu, Sep 26, 2013 at 04:35:27PM -0300, Ezequiel Garcia wrote:
> > > > > > > > This commit introduces a new group of clocks present in Armada 370/XP
> > > > > > > > SoCs (called "Core Divider" clocks) and add a provider for them.
> > > > > > > > The only clock supported for now is the NAND clock (ndclk), but the
> > > > > > > > infrastructure to add the rest is already set.
> > > > > > > > 
> > > > > > > > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > > > > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > > > > > ---
> > > > > > > >  drivers/clk/mvebu/Kconfig       |   5 +
> > > > > > > >  drivers/clk/mvebu/Makefile      |   1 +
> > > > > > > >  drivers/clk/mvebu/clk-corediv.c | 223 ++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 229 insertions(+)
> > > > > > > >  create mode 100644 drivers/clk/mvebu/clk-corediv.c
> > > > > > > 
> > > > > > > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > > > > > > 
> > > > > > 
> > > > > > Mike: any comments on this?
> > > > > 
> > > > > ping?
> > > > > 
> > > > > I'd like to move along with the NAND driver for this controller and
> > > > > -although these are not a hard requirement- it would be nice
> > > > > to have them merged.
> > > > > 
> > > > 
> > > > Mike? Any chance you pick these soon? It's been almost three-weeks since
> > > > these patchset has been sent and I'm starting to forget the details of it ;)
> > > 
> > > Jason: It seems Mike went on 'stealth mode' so I'm wondering if you would
> > > consider taking this patchset through you (given it's for our SoCs).
> > 
> > I considered it, and it didn't sit well with me.  I don't mind taking a
> > bugfix, everyone wants to see those moved along.  However, this is an
> > entirely new driver.  Yes, it's scope of use is limited, but I'd prefer
> > to let the maintainer review the driver before agreeing to maintain it.
> > Otherwise, I'd be forcing him to maintain something he hasn't even
> > looked at.  :(
> > 
> > I know it sucks, but we're going to wait for Mike.
> 
> Sorry for the delay. This driver looks fine and I've taken it into
> clk-next.
> 

This commit doesn't seem to be in clk-next (or in any other place),
nearly two months after I submitted it, and after a month I was told
it was accepted.

What's going on?

I really hope I'm missing something or I'm looking at the wrong tree.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
