From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Apr 2010 09:58:13 -0700
Subject: [GIT PULL] omap fixes for v2.6.34-rc5
In-Reply-To: <alpine.LFD.2.00.1004270934220.3739@i5.linux-foundation.org>
References: <20100426190005.GJ7225@atomide.com>
	<alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
	<20100427161217.GB7225@atomide.com>
	<alpine.LFD.2.00.1004270934220.3739@i5.linux-foundation.org>
Message-ID: <20100427165813.GC7225@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Torvalds <torvalds@linux-foundation.org> [100427 09:31]:
> 
> 
> On Tue, 27 Apr 2010, Tony Lindgren wrote:
> > 
> > OK point taken. I should have dealt with this earlier. Will only queue
> > regressions after -rc3 or so.
> 
> Note that the "only regressions" is certainly not a hard rule. Anything 
> that would be valid for -stable is obviously always valid: security 
> issues, major oopses etc etc.

Sure.
 
> But the "only regressions" should kind of be the guiding line, and the 
> others are more like "this is so serious that it should go in regardless 
> of anything else".

OK. I guess was using criteria like "this is needed to boot this and that
board in a usable way" and "let's get all the fixes in" criteria, but that
should have been done way earlier.

Regards,

Tony
