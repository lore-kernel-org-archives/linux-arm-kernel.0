From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 20 Jun 2011 09:48:52 -0400 (EDT)
Subject: [PATCH 1/2] ARM: kuser: move interface documentation out of the
	source code
In-Reply-To: <20110620130523.GC2067@arm.com>
References: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
	<1308502494-20938-2-git-send-email-nico@fluxnic.net>
	<20110620130523.GC2067@arm.com>
Message-ID: <alpine.LFD.2.00.1106200939170.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Dave Martin wrote:

> On Sun, Jun 19, 2011 at 12:54:53PM -0400, Nicolas Pitre wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > Digging into some assembly file in order to get information about the
> > kuser helpers is not that convivial.  Let's move that information to
> > a better formatted file in Documentation/arm/ and improve on it a bit.
> > 
> > Thanks to Dave Martin <dave.martin@linaro.org> for the initial cleanup and
> > clarifications.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> btw, we could lose some trailing whitespace in the new documentation text.
> (Annotated as '!' in the inline patch below.)
> 
> The trailing space doesn't seem to have been present in the original
> source file ... maybe it got added as a side-effect of rewrapping the text?

Probably.  All fixed up yesterday, thanks to 'git rebase 
--whitespace=fix'.

I also folded your initial patch into the one performing the 
documentation move.  I was worried about adding more text in the 
comments just to rip them out the very next patch could be seen as 
needless churn.

I pushed the result here:

	http://git.linaro.org/git/people/nico/linux.git cmpxchg64


Nicolas
