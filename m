From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 13:50:53 +0100
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <20111020124847.GG32007@S2100-06.ap.freescale.net>
References: <4E97A601.1020005@gmail.com>
	<20111020124847.GG32007@S2100-06.ap.freescale.net>
Message-ID: <20111020125053.GB21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 08:48:48PM +0800, Shawn Guo wrote:
> On Thu, Oct 13, 2011 at 10:01:21PM -0500, Rob Herring wrote:
> > Rob Herring (4):
> >       of/irq: introduce of_irq_init
> >       irq: support domains with non-zero hwirq base
> >       ARM: gic: add irq_domain support
> >       ARM: gic: add OF based initialization
> > 
> Hi Rob,
> 
> Russell is going to take Marc Zyngier's ppi series for v3.2 merge
> window.  I just noticed your patch 'ARM: gic: add irq_domain support'
> gets some conflict with Marc's series on function gic_dist_init(),
> which is not so obvious to resolve.  You may want to take a look. 

Don't be so sure - Marc has rebased commits which exist in Thomas' tree,
so I can't pull it as-is.  That needs to be resolving - but unfortunately
Thomas is not responding (I suspect he's busy elsewhere also because of
the proximity of the kernel summit.)

Given that this is my _last_ full working day before the kernel summit,
time is running very short to resolve these problems.  So, I think that
all this GIC stuff may have to wait until after the KS, and maybe for
the following merge window too.
