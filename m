From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 13:17:31 -0500
Subject: [PATCH v2] ARM: kirkwood: convert Guruplug Server Plus to use
 the device tree
In-Reply-To: <20130107180849.GA28008@1wt.eu>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net>
 <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net>
 <20121209184004.GC28052@1wt.eu>
 <20130107174831.GN5075@titan.lakedaemon.net>
 <20130107180849.GA28008@1wt.eu>
Message-ID: <20130107181731.GQ5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 07:08:49PM +0100, Willy Tarreau wrote:
> Hi Jason,
> 
> On Mon, Jan 07, 2013 at 12:48:31PM -0500, Jason Cooper wrote:
> > On Sun, Dec 09, 2012 at 07:40:04PM +0100, Willy Tarreau wrote:
> > > From 075e116c6cb513af0e0b9d9167ddd47e1b084bca Mon Sep 17 00:00:00 2001
> > > From: Willy Tarreau <w@1wt.eu>
> > > Date: Sun, 9 Dec 2012 19:21:09 +0100
> > > Subject: ARM: kirkwood: convert Guruplug Server Plus to device tree
> > > 
> > > Add a device tree entry for the Guruplug Server Plus board. This port
> > > was based both on the work done on the dreamplug and the dockstar.
> > > 
> > > It builds, boots and works on my Guruplug Server Plus.
> > > 
> > > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > > ---
> > >  arch/arm/boot/dts/Makefile                         |  1 +
> > >  .../arm/boot/dts/kirkwood-guruplug-server-plus.dts | 94 ++++++++++++++++++++++
> > >  arch/arm/mach-kirkwood/Kconfig                     |  7 ++
> > >  arch/arm/mach-kirkwood/Makefile                    |  1 +
> > >  arch/arm/mach-kirkwood/board-dt.c                  |  4 +
> > >  arch/arm/mach-kirkwood/board-guruplug.c            | 39 +++++++++
> > >  arch/arm/mach-kirkwood/common.h                    |  5 ++
> > >  7 files changed, 151 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
> > >  create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
> > 
> > Applied to mvebu/boards.
> 
> I'm assuming you meant kirkwood instead of mvebu here, but thanks anyway !

mach-mvebu is where everything is being migrated to once the DT
conversion is complete.  We use the name internally to refer to any SoCs
created by Marvell in the EBU division.

So, yes, it's kirkwood, but it falls under mvebu stuff.  Just like dove
and orion5x.

hth,

Jason.
