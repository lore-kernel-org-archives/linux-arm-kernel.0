From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Oct 2013 08:08:20 -0300
Subject: [PATCH v2 1/4] clk: mvebu: Add Core Divider clock
In-Reply-To: <20131008195933.GA2473@localhost>
References: <1380224130-11868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380224130-11868-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131002174332.GQ31178@titan.lakedaemon.net>
 <20131002180944.GC2365@localhost> <20131008195933.GA2473@localhost>
Message-ID: <20131016110819.GC2518@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 04:59:33PM -0300, Ezequiel Garcia wrote:
> On Wed, Oct 02, 2013 at 03:09:44PM -0300, Ezequiel Garcia wrote:
> > On Wed, Oct 02, 2013 at 01:43:32PM -0400, Jason Cooper wrote:
> > > On Thu, Sep 26, 2013 at 04:35:27PM -0300, Ezequiel Garcia wrote:
> > > > This commit introduces a new group of clocks present in Armada 370/XP
> > > > SoCs (called "Core Divider" clocks) and add a provider for them.
> > > > The only clock supported for now is the NAND clock (ndclk), but the
> > > > infrastructure to add the rest is already set.
> > > > 
> > > > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > ---
> > > >  drivers/clk/mvebu/Kconfig       |   5 +
> > > >  drivers/clk/mvebu/Makefile      |   1 +
> > > >  drivers/clk/mvebu/clk-corediv.c | 223 ++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 229 insertions(+)
> > > >  create mode 100644 drivers/clk/mvebu/clk-corediv.c
> > > 
> > > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > > 
> > 
> > Mike: any comments on this?
> 
> ping?
> 
> I'd like to move along with the NAND driver for this controller and
> -although these are not a hard requirement- it would be nice
> to have them merged.
> 

Mike? Any chance you pick these soon? It's been almost three-weeks since
these patchset has been sent and I'm starting to forget the details of it ;)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
