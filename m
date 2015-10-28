From: joe@perches.com (Joe Perches)
Date: Wed, 28 Oct 2015 10:56:36 -0700
Subject: [PATCH] get_maintainer: Add subsystem to reviewer output
In-Reply-To: <20151028174932.GK4058@x1>
References: <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
 <20151028093907.GP4931@pengutronix.de> <20151028095524.GP5828@x1>
 <5630CA06.7050503@samsung.com> <1446050506.2757.109.camel@perches.com>
 <20151028170116.GI4058@x1> <1446052121.2757.120.camel@perches.com>
 <20151028172208.GJ4058@x1> <1446053411.2757.131.camel@perches.com>
 <20151028174932.GK4058@x1>
Message-ID: <1446054996.2757.139.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 17:49 +0000, Lee Jones wrote:
> On Wed, 28 Oct 2015, Joe Perches wrote:
> > On Wed, 2015-10-28 at 17:22 +0000, Lee Jones wrote:
> > > On Wed, 28 Oct 2015, Joe Perches wrote:
> > > > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > It'd be better if you could add a "tested-by:" instead.
> > > 
> > > Patch works as expected:
> > >   Tested-by: Lee Jones <lee.jones@linaro.org>
> > []
> > >       "I'm sure we can make the output even more similar by listing
> > >       the MAINTAINERS tag after "reviewer" too."
> > 
> > I guess we'll disagree on that one too.
> 
> You just happened to think of it a few hours after I mentioned it.

Nope, it seems a maintainers tag is what Krzysztof was suggesting
with his "supported reviewer" bit.

I added the subsystem name.

An issue for that will be how multiple subsystem section matching
affects the output for reviewers who are also maintainers.
