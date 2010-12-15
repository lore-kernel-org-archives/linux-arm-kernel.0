From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 15 Dec 2010 07:31:23 +0530
Subject: [PATCH v1 7/9] OMAP1: DMA: Implement in platform device model
In-Reply-To: <20101215010400.GC3190@atomide.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-8-git-send-email-manjugk@ti.com>
	<87d3p3q35h.fsf@deeprootsystems.com>
	<87aak7onvu.fsf@deeprootsystems.com>
	<20101215010400.GC3190@atomide.com>
Message-ID: <20101215020123.GB6725@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 05:04:00PM -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [101214 16:55]:
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> > 
> > [...]
> > 
> > >
> > > Using the patch below which fixes up the interrupt numbers to match the
> > > original code, the memory-to-memory test is now working on OSK.
> > 
> > Tony, if you prefer just to fold this into the original, feel free to
> > add
> > 
> > [khilman at deeprootsystems.com]: fixed IRQ numbers to match original code
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> OK thanks, will fold it in and let's merge them into linux-omap
> master branch for few days for testing. Then if everything looks
> good, I'll queue these for the 2.6.38 next merge window.

Thanks Tony.

-Manjunath
