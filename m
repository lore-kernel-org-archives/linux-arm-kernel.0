From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Mar 2011 00:09:35 -0700
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
Message-ID: <20110318070935.GC3555@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Torvalds <torvalds@linux-foundation.org> [110317 20:00]:
> On Thu, Mar 17, 2011 at 11:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Please pull omap changes for this merge window from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus
> 
> Btw, that "generic hardware spinlock" thing needs to be hidden from
> sane people and architectures that don't need it.
> 
> Make platforms that need it "select" it or something. It looks like
> nobody but an OMAP4 could _possibly_ ever want to answer 'y' to that
> question, SO DON'T ASK IT!

No problem, let's make it depends on OMAP4.

Regards,

Tony
