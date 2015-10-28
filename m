From: joe@perches.com (Joe Perches)
Date: Wed, 28 Oct 2015 05:46:10 -0700
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <20151028122417.GB4058@x1>
References: <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
 <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
 <1446030399.2757.83.camel@perches.com>
 <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
 <20151028113932.GS5828@x1> <20151028121454.GA4058@x1>
 <1446034810.2757.87.camel@perches.com> <20151028122417.GB4058@x1>
Message-ID: <1446036370.2757.104.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 12:24 +0000, Lee Jones wrote:
> On Wed, 28 Oct 2015, Joe Perches wrote:
> > On Wed, 2015-10-28 at 12:14 +0000, Lee Jones wrote:
> > > Ah, but wait.  get_maintainer.pl *does* assume M means Maintainer
> > > doesn't it?
> > 
> > No, it looks at the "S:" line.
> 
> Right.  Then assumes because the driver is 'supported' or 'maintained'
> that the person(s) listed in M: must be the Supporter(s) or the
> Maintainer(s).

Yup, except "assumes" isn't correct.

It's your definition of maintainer that seems to be at odds
with what's otherwise apparently commonly accepted.

Any "M:" entry in a section where the "S:" line is maintained
or supported is generally classified as a maintainer too.

For instance: I think most accept that I am a maintainer of
get_maintainer.pl.

I wrote most of get_maintainer and I accept most but not all
patches to it by acking some and nacking or otherwise requesting
changes in others.  I do not upstream it.

I don't have a git tree at kernel.org and don't really need one.
I rarely send pull requests.  I generally upstream through
Andrew Morton and he uses quilt.  It's working well enough.

The kernel summit thread from last year that initiated the "R:"
line in MAINTAINERS was primarily focused on encouraging new
patch review and honoring those that already take time to review.

http://lists.linuxfoundation.org/pipermail/ksummit-discuss/2014-May/000764.html

Knock your self out about clarifying how process should work.
Generate consensus where necessary but don't try too hard.

It's working reasonably well right now.  Most people are able
to maintain sanity by ignoring what's unimportant to them.
