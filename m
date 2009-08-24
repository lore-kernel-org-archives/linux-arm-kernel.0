From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 24 Aug 2009 12:52:17 -0700 (PDT)
Subject: ARM subarch submissions for next merge window
In-Reply-To: <877hwtnxdx.fsf@deeprootsystems.com>
References: <877hwtnxdx.fsf@deeprootsystems.com>
Message-ID: <alpine.LFD.2.01.0908241249200.3158@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 24 Aug 2009, Kevin Hilman wrote:
> 
> After some discussions on linux-arm-kernel during the last merge
> window, a suggestion from Alan Cox[1], and a willingness to try it
> from Russell[2], some ARM subarch maintainers would like to push our
> platform-specific code directly to you for the next merge window.
> 
> Any changes that affect common ARM code will still be pushed via
> Russell, only our platform-specific code will be submitted directly.
> 
> Also our platform code is still posted and reviewed on
> linux-arm-kernel as well as being included in linux-next. Only the
> merge path will change slightly.
> 
> Any problems with this?

I don't have any issues with it, as long as the subarch trees are clean 
and clear.

Part of that is the normal "git cleanliness" issue in general (ie I don't 
want to see ugly back-merges of my random kernel-of-the-day or see that 
something was rebased just five minutes ago and clearly had no testing), 
but the other part is obviously that if there then ends up being 
complaints where people end up stepping on each others toes, I would want 
a top-level maintainer to step in.

But I guess that as long as it's clearly just platform-specific files, 
that won't be a problem.

		Linus
