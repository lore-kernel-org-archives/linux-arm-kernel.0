From: joe@perches.com (Joe Perches)
Date: Wed, 28 Oct 2015 04:06:39 -0700
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
 <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
Message-ID: <1446030399.2757.83.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 11:53 +0100, Javier Martinez Canillas wrote:
> (Lee) think(s) that the difference between a maintainer and
> a reviewer is if a branch with fixes / new features are kept and pull
> requests sent while I think that the difference is the level of
> involvement someone has with a driver regardless of how patches ends
> in the subsystem tree (picked directly by subsystem maintainers or
> sent through pull requests).
> 
> Is the first time I heard your definition but maybe I'm the one that
> is wrong so it would be great to get a consensus on that and get it
> documented somewhere.

I think Lee is over-analyzing.

>From MAINTAINERS:
	M: Mail patches to: FullName <address@domain>
	R: Designated reviewer: FullName <address@domain>
	   These reviewers should be CCed on patches.
	S: Status, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.

"looking after" doesn't mean upstreaming.

The original threads for this were:

http://lists.linuxfoundation.org/pipermail/ksummit-discuss/2014-May/000830.html
https://lkml.org/lkml/2014/6/2/446
