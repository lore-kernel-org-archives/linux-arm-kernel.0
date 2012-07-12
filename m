From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jul 2012 15:54:02 +0000
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120712131231.GH2194@pengutronix.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
Message-ID: <201207121554.03240.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 July 2012, Wolfram Sang wrote:
> 
> > I fixed it up (I think - see below) and can carry the fix as necessary.
> > Please check this and talk to each other ...
> 
> I also noticed the bindings today [1]. They came in via a seperate
> patch (suboptimal) which has no ack by a devicetree maintainer which I'd
> really like to see here, because the bindings look suspicious to me.
> They look like they mostly export register settings which is usually
> questionable since we might want to abstract bindings so they can be
> useful for a number of drivers.
> 
> Arnd, since you committed the patches, can you please comment? I'd
> prefer to drop this DT conversion for now, otherwise we might have to
> support this possibly rushed bindings forever? LinusW, what do you
> think?

I've dropped the ux500/dt branch for now. and will wait for a new one
to get submitted as a replacement. There were other things wrong with
the submission that Lee already knows about, so I think it's better
to do this the proper way now.

	Arnd
