From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 17 Oct 2013 16:18:53 -0300
Subject: [PATCH v2 1/4] clk: mvebu: Add Core Divider clock
In-Reply-To: <20131016110819.GC2518@localhost>
References: <1380224130-11868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380224130-11868-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131002174332.GQ31178@titan.lakedaemon.net>
 <20131002180944.GC2365@localhost> <20131008195933.GA2473@localhost>
 <20131016110819.GC2518@localhost>
Message-ID: <20131017191852.GA8832@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 08:08:19AM -0300, Ezequiel Garcia wrote:
> On Tue, Oct 08, 2013 at 04:59:33PM -0300, Ezequiel Garcia wrote:
> > On Wed, Oct 02, 2013 at 03:09:44PM -0300, Ezequiel Garcia wrote:
> > > On Wed, Oct 02, 2013 at 01:43:32PM -0400, Jason Cooper wrote:
> > > > On Thu, Sep 26, 2013 at 04:35:27PM -0300, Ezequiel Garcia wrote:
> > > > > This commit introduces a new group of clocks present in Armada 370/XP
> > > > > SoCs (called "Core Divider" clocks) and add a provider for them.
> > > > > The only clock supported for now is the NAND clock (ndclk), but the
> > > > > infrastructure to add the rest is already set.
> > > > > 
> > > > > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > > ---
> > > > >  drivers/clk/mvebu/Kconfig       |   5 +
> > > > >  drivers/clk/mvebu/Makefile      |   1 +
> > > > >  drivers/clk/mvebu/clk-corediv.c | 223 ++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 229 insertions(+)
> > > > >  create mode 100644 drivers/clk/mvebu/clk-corediv.c
> > > > 
> > > > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > > > 
> > > 
> > > Mike: any comments on this?
> > 
> > ping?
> > 
> > I'd like to move along with the NAND driver for this controller and
> > -although these are not a hard requirement- it would be nice
> > to have them merged.
> > 
> 
> Mike? Any chance you pick these soon? It's been almost three-weeks since
> these patchset has been sent and I'm starting to forget the details of it ;)

Jason: It seems Mike went on 'stealth mode' so I'm wondering if you would
consider taking this patchset through you (given it's for our SoCs).

The patches have been reviewed by Gregory and have your Ack, but
unfortunately I don't know if Mike took a look on them.

On the other side, this adds a new clock to be used with NAND,
so it's completely isolated and innocuous.

I hate to re-route patches this way -so feel free to refuse- but other
I don't see any way this can be in v3.13.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
