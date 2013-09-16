From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Sep 2013 09:57:23 +0100
Subject: [PATCH 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <20130915083658.GH23705@lunn.ch>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
 <520CE665.8060907@gmail.com>
 <20130815152238.GF17839@e102568-lin.cambridge.arm.com>
 <20130913165708.GC5408@e102568-lin.cambridge.arm.com>
 <20130915083658.GH23705@lunn.ch>
Message-ID: <20130916085723.GB22390@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 09:36:58AM +0100, Andrew Lunn wrote:
> > > > > +			    "faraday,fa526"
> > > > > +			    "intel,sa110"
> > > > > +			    "intel,sa1100"
> > > > > +			    "marvell,feroceon"
> > > > > +			    "marvell,mohawk"
> > > > > +			    "marvell,pj4"
> > > > > +			    "marvell,sheeva-v7"
> > > > > +			    "marvell,xsc3"
> > > > > +			    "marvell,xscale"
> > > > 
> > > > Better make sure the Marvell folks are happy with these. We don't need
> > > > another rename here. I'm too annoyed with all the renames to pay attention.
> > > 
> > > Ok, I will verify that, I copied maintainers in.
> 
> Hi Lorenzo
> 
> Here are the compatibility strings we would like, and a comment about
> which SoCs will/do use them.
> 
> "marvell,feroceon"  - Orion5x
> "marvell,sheeva-v5" - Mv78xx0, Kirkwood
> "marvell,pj4a"      - Dove
> "marvell,pj4b"      - Armada XP, Armada 370, Armada 1500
> "marvell,mohawk"    - Armada 100
> 
> "marvell,xscale" & "marvell,xsc3" should be removed.
> 
> The compatibility strings are not correct, or present in all the
> current <soc>.dtsi files. 
> 
> orion5x cpus needs adding.
> mv78xx0 needs adding.
> kirkwood.dtsi needs changing.
> armada-370-xp.dtsi need changing.
> armada-xp-mv*.dtsi needs changing.
> 
> We will deal with these in the next cycle.

Thank you very much Andrew, appreciated. I will update the document
accordingly and should be able to post a final version very soon.

Lorenzo
