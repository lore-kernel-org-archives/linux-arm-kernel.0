From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Mar 2011 16:43:18 -0700
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <AANLkTin-dwhmFjF=g90tMvGMS1hv-cod9WrQiaLfYygS@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
	<20110318070935.GC3555@atomide.com>
	<AANLkTin-dwhmFjF=g90tMvGMS1hv-cod9WrQiaLfYygS@mail.gmail.com>
Message-ID: <20110318234318.GC18583@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [110318 01:04]:
> On Fri, Mar 18, 2011 at 9:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Torvalds <torvalds@linux-foundation.org> [110317 20:00]:
> >> Make platforms that need it "select" it or something. It looks like
> >> nobody but an OMAP4 could _possibly_ ever want to answer 'y' to that
> >> question, SO DON'T ASK IT!
> >
> > No problem, let's make it depends on OMAP4.
> 
> From d086e8f994b9272f8c999af0a4d32d870749c77a Mon Sep 17 00:00:00 2001
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Fri, 18 Mar 2011 10:01:11 +0200
> Subject: [PATCH] hwspinlock: depend on OMAP4
> 
> Currently only OMAP4 supports hwspinlocks, so don't bother asking
> anyone else.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks I'll queue this.

Regards,

Tony
