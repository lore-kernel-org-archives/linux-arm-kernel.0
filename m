From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Oct 2015 11:39:32 +0000
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
References: <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
 <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
 <1446030399.2757.83.camel@perches.com>
 <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
Message-ID: <20151028113932.GS5828@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015, Javier Martinez Canillas wrote:

> Hello Joe,
> 
> On Wed, Oct 28, 2015 at 12:06 PM, Joe Perches <joe@perches.com> wrote:
> > On Wed, 2015-10-28 at 11:53 +0100, Javier Martinez Canillas wrote:
> >> (Lee) think(s) that the difference between a maintainer and
> >> a reviewer is if a branch with fixes / new features are kept and pull
> >> requests sent while I think that the difference is the level of
> >> involvement someone has with a driver regardless of how patches ends
> >> in the subsystem tree (picked directly by subsystem maintainers or
> >> sent through pull requests).
> >>
> >> Is the first time I heard your definition but maybe I'm the one that
> >> is wrong so it would be great to get a consensus on that and get it
> >> documented somewhere.
> >
> > I think Lee is over-analyzing.
> >
> > From MAINTAINERS:
> >         M: Mail patches to: FullName <address@domain>
> >         R: Designated reviewer: FullName <address@domain>
> >            These reviewers should be CCed on patches.
> >         S: Status, one of the following:
> >            Supported:   Someone is actually paid to look after this.
> >            Maintained:  Someone actually looks after it.
> >
> > "looking after" doesn't mean upstreaming.
> >
> 
> Agreed and upstreaming doesn't mean sending pull request, you can for
> example upstream the downstream changes for a driver you maintain by
> posting patches or ack patches others post and let the subsystem
> maintainer to pick those (even if you are listed as the driver
> maintainer in MAINTAINERS).
> 
> So by following Lee's definition, then most drivers' maintainers
> should not be called maintainers since keeping a tree with patches for
> both fixes and new features, sending pull requests, etc is only
> justified for drivers that have a lot of changes per release. Is not
> worth it for drivers that are in "maintenance mode" where only bugs
> are fixed every once in a while or features are seldom added.

Exactly right.

Although, it looks like M: doesn't even mean Maintainer.  If it did, I
would have made these points over and over until death (or until I got
bored).  However, as M: actually means "Mail patches to", there seems
to be very little difference between that and "Designated reviewer"
and makes me wonder why the R: tag was ever even introduced.  I guess
all of the other guys in the threads below also thought M: meant
Maintainer, or else they would have just added poor old Josh as a
"Mail patches to" recipient and been done with it.

> > The original threads for this were:
> >
> > http://lists.linuxfoundation.org/pipermail/ksummit-discuss/2014-May/000830.html
> > https://lkml.org/lkml/2014/6/2/446

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
