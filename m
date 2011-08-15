From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Aug 2011 14:32:07 +0100
Subject: [PATCH 1/3] ARM: mmp: add sram allocator
In-Reply-To: <alpine.LFD.2.00.1108150920060.20358@xanadu.home>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377794-26721-2-git-send-email-leoy@marvell.com>
	<1403041.Yj2MdIhcZO@wuerfel>
	<alpine.LFD.2.00.1108150920060.20358@xanadu.home>
Message-ID: <20110815133207.GG26827@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 09:23:49AM -0400, Nicolas Pitre wrote:
> On Mon, 15 Aug 2011, Arnd Bergmann wrote:
> 
> > Some time ago, there was talk of merging the existing sram drivers
> > and creating a common driver that is easy to hook into.
> 
> Absolutely.
> 
> > What has happened with that? My feeling is that we should stop adding
> > more drivers like this in the platform code but rather put an
> > authoritative copy into arch/arm/mm/ or even the top-level mm/ directory
> > and change over the existing drivers to hook into that one.
> 
> IIRC, this was driven by Russell.  Maybe this is a good time to revive 
> discussion around it.

As I understand it, Jean-Christophe's patches were essentially a
replacement for my infrastructure changes, and it is Jean-Christophe's
patches which went in.  So, my work is obsolete.

I'm not sure what else there is to be done here - if Jean-Christophe's
genpool interfaces are not sufficient, maybe when the discussion surrounding
my patches and Jean-Christophe's patches happened, maybe someone should've
sorted out finishing off Jean-Christophe's patches to the same extent
that mine have.  Or maybe my patches should've been merged instead of
Jean-Christophe's and Jean-Christophe's brought forward to plug into the
core of my patches.

Either way, I completely gave up with the idea because I saw no future
for my patches, and now I'm no longer interested in it.
