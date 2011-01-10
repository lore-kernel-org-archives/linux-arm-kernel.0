From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 11 Jan 2011 00:45:14 +0900
Subject: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
In-Reply-To: <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
References: <20110109124928.GC25591@verge.net.au>
	<1294589548.8897.1.camel@rojo>
	<20110109225042.GB29257@verge.net.au>
	<c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
Message-ID: <20110110154514.GC3760@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 10:10:19AM +0000, Pawel Moll wrote:
> On Mon, 10 Jan 2011 07:50:42 +0900, Simon Horman <horms@verge.net.au> 
> wrote:
> >>>  Documentation/arm/SH-Mobile/Makefile              |    8 +
> >>>  Documentation/arm/SH-Mobile/vrl4.c                |  169 
> >>+++++++++++++++++++++
> >>How about putting those two into "tools" (in particular "tools/arm")
> >>instead of "Documentation"?
> >>Just a thought... ;-)
> >
> >Thats fine by me except that tools/arm doesn't exist yet.
> >It would be good to get some consensus before creating it.
> 
> I think there is consensus regarding "tools" as a place for user-space 
> tools - eg. perf tools used to live in "Documentation/..." and then were 
> moved to "tools/perf".
> 
> Now, whether your stuff should be in "tools/SH-Mobile" or 
> "tools/arm/SH-Mobile", I have no opinion ;-)
> 
I agree that this is a worthwhile direction to move to, but we're a long
way from a consensus. x86 has traditionally littered scripts/ and others
have sunk to arch/<foo>/tools hostprogs abuse and so forth. perf is a bit
of a special case in that it's fairly architecture agnostic. 
