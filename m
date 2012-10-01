From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 30 Sep 2012 20:02:47 -0400
Subject: [GIT PULL] ARM: mvebu: cache-l2x0 DT for v3.7
In-Reply-To: <20120930035503.GB477@quad.lixom.net>
References: <20120930015012.GB17765@titan.lakedaemon.net>
 <20120930035503.GB477@quad.lixom.net>
Message-ID: <20121001000247.GF17765@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2012 at 08:55:03PM -0700, Olof Johansson wrote:
> On Sat, Sep 29, 2012 at 09:50:12PM -0400, Jason Cooper wrote:
> > Depends:
> >  - Based on arm-soc/late/kirkwood
> >  - Patches going through rmk's patch tracker:
> >     - arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
> >     - arm: cache-l2x0: add an optional register to save/restore
> >     - arm: cache-l2x0: add support for Aurora L2 cache ctrl
> > 
> >     - feature-use dependency only.  No build breakage or failed boot
> >       should occur.  Until patches from rmk's tracker land, driver
> >       won't know about compatible property, so it's like the driver
> >       isn't there.
> > 
> > Adds:
> >  - cache-l2x0 DT entry for Marvell Armada (mvebu) SoCs
> 
> I'd prefer to hold off on this until we know that Russell is happy with
> the l2x0 changes, just in case this part of the series might need revising
> (i.e.  bindings changes). Please resend when he has picked them up!

Will do.  These are on ice.

thx,

Jason.
