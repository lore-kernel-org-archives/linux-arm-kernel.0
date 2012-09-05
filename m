From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Sep 2012 05:55:30 +0200
Subject: [PATCH] arm: mxs: Fix MMC WP pin being inverted
In-Reply-To: <20120905031953.GU2362@S2101-09.ap.freescale.net>
References: <1346811082-27295-1-git-send-email-marex@denx.de>
 <201209050457.03707.marex@denx.de>
 <20120905031953.GU2362@S2101-09.ap.freescale.net>
Message-ID: <201209050555.30635.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Wed, Sep 05, 2012 at 04:57:03AM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > Please resend with subject "arm: " changing to "ARM: ", or even better
> > > the one below.
> > > 
> > >   ARM: dts: m28evk: ...
> > 
> > I really don't like this game ...
> 
> You either stay out of the game or play it well.

You know, as I already complained, well defined rules would be welcome.

All these tags seem to me just as a tool for maintainers to unnecesarily torture 
people. I'd be much happier if we had a tool or something that'd either check 
them or generate them -- that'd make my life much easier. I think I'm not alone 
here.

Maybe a checkpatch-alike tool? But we have no list of valid tags, so, there're 
no well-defined rules, only some unspoken agreement :-(

Best regards,
Marek Vasut
