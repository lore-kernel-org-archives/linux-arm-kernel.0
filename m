From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Apr 2012 11:44:27 -0700
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
In-Reply-To: <87pqchv1pc.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
 <20120311204232.GC3171@opensource.wolfsonmicro.com>
 <87399dzq5e.fsf@ti.com>
 <20120312173215.GL3110@opensource.wolfsonmicro.com>
 <87pqchv1pc.fsf@ti.com>
Message-ID: <20120403184426.GJ8240@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120312 16:30]:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > On Mon, Mar 12, 2012 at 10:26:53AM -0700, Kevin Hilman wrote:
> >> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> >
> >> > The branch itself is essentially stable but I'm not enthused about the
> >> > idea of merging the whole thing via the OMAP tree.  
> >
> >> Right, I wasn't suggesting we merge it via OMAP tree.   I was just
> >> looking for a stable point we could use as s dependency when merging
> >> everything together for the arm-soc tree.
> >
> > Well, if you don't base the OMAP changes that depend on it off the
> > regulator changes then you'll break bisection as you'll have a bunch of
> > commits which won't have all their dependencies present on a branch
> > (since they're not present in the branch point and aren't otherwise
> > merged in), if bisect goes down that branch it'll be miserable.  That
> > seems bad and while I've not run into it with OMAP in particular it's
> > rather painful when it does happen.
> >
> > It's much better if the branch has the required changes merged into it
> > prior to their being used.
> 
> OK.
> 
> Tony, updated pull request below.  This includes all the TWL depencies
> merged from the 'topic/twl' tag in Mark's tree.

Pulled in this into pm-regulator branch finally.

Tony
