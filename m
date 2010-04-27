From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 27 Apr 2010 08:31:59 -0700 (PDT)
Subject: [GIT PULL] omap fixes for v2.6.34-rc5
In-Reply-To: <20100426190005.GJ7225@atomide.com>
References: <20100426190005.GJ7225@atomide.com>
Message-ID: <alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 26 Apr 2010, Tony Lindgren wrote:
> 
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

I pulled it this time, but I'm starting to get really irritated with you.

These look like real fixes, but quite frankly, by -rc5, that IS NOT 
ENOUGH. 

They need to be _regressions_, not just cleanups and fixes for things that 
have never worked. And this is starting to be a pattern with the omap 
tree: you're not honoring the merge window properly.

Just "it's a bug-fix" or "it's deleting unused code" is not enough. The 
point of the late -rc series is to fix problems from the merge window, not 
add new changes. I realize that you think that all the new changes are 
obviously good, but the fact is, bugs happen even in "obvious bug-fixes". 

And that's why we have the rule about late-rc pulls being about 
_regressions_ and/or major oopses/security issues. Not just random 
development that are meant to improve things.

		Linus
