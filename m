From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 27 Apr 2010 09:35:45 -0700 (PDT)
Subject: [GIT PULL] omap fixes for v2.6.34-rc5
In-Reply-To: <20100427161217.GB7225@atomide.com>
References: <20100426190005.GJ7225@atomide.com>
	<alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
	<20100427161217.GB7225@atomide.com>
Message-ID: <alpine.LFD.2.00.1004270934220.3739@i5.linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 27 Apr 2010, Tony Lindgren wrote:
> 
> OK point taken. I should have dealt with this earlier. Will only queue
> regressions after -rc3 or so.

Note that the "only regressions" is certainly not a hard rule. Anything 
that would be valid for -stable is obviously always valid: security 
issues, major oopses etc etc.

But the "only regressions" should kind of be the guiding line, and the 
others are more like "this is so serious that it should go in regardless 
of anything else".

			Linus
