From: pza@pengutronix.de (Philipp Zabel)
Date: Wed, 29 Jun 2016 23:57:04 +0200
Subject: [PATCH 4/7] reset: Supply *_shared variant calls when using
 *_optional APIs
In-Reply-To: <20160629093734.GL29166@dell>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-5-lee.jones@linaro.org>
 <20160628085622.GM6720@dell>
 <1467186499.2278.7.camel@pengutronix.de>
 <20160629080611.GH29166@dell>
 <1467192201.2278.9.camel@pengutronix.de>
 <20160629093734.GL29166@dell>
Message-ID: <20160629215704.GA29796@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jun 29, 2016 at 10:37:34AM +0100, Lee Jones wrote:
[...]
> > > > If that is not the case, go ahead. Otherwise I could provide
> > > > a tag at commit 2485394d9e0b ("reset: TRIVIAL: Add line break at same
> > > > place for similar APIs") for you to merge.
> > > 
> > > Yes please.  If you could tag a branch containing commit:
> > > 
> > >   reset: Supply *_shared variant calls when using *_optional APIs
> > > 
> > > ... that would be perfect.  Would you mind sending me the tag name
> > > ASAP please, since I am ready to send my pull-request to Linus.
> > 
> > git://git.pengutronix.de/git/pza/linux.git tags/reset-shared-optional
> 
> Ah!  If I rebase on that tag, I will also take in all of the patches
> between it and v4.7-rc1, which is 14 commits.  Is there any way you
> can place it onto it's own branch, then we both merge it into our
> respective trees?

I have now moved your patches into their own branch at
git://git.pengutronix.de/git/pza/linux.git tags/reset-explicit-api
and merged that back in.

regards
Philipp
