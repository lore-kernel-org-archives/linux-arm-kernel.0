From: tony@atomide.com (Tony Lindgren)
Date: Sun, 16 Apr 2017 12:28:10 -0700
Subject: [GIT PULL] omap deferred probe regression fix
In-Reply-To: <20170416185427.GA6930@localhost>
References: <58ebbb9c.8cde540a.c8344.2677SMTPIN_ADDED_BROKEN@mx.google.com>
 <20170416185427.GA6930@localhost>
Message-ID: <20170416192810.GW5339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [170416 12:03]:
> On Mon, Apr 10, 2017 at 10:06:27AM -0700, Tony Lindgren wrote:
> > The following changes since commit 351b7c490700747d1dba1b0a10fbfe3448d11c35:
> > 
> >   ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot (2017-03-27 10:10:42 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc6-signed
> > 
> > for you to fetch changes up to 04abaf07f6d5cdf22b7a478a86e706dfeeeef960:
> > 
> >   ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer (2017-04-04 08:49:56 -0700)
> > 
> > ----------------------------------------------------------------
> > Regression fix for omap interconnect code for deferred probe.
> > Without this fix we can get PM related warnings for devices that
> > use deferred probe. If necessary, this fix can wait for the
> > v4.12 merge window no problem.
> > 
> > ----------------------------------------------------------------
> > Dave Gerlach (1):
> >       ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer
> 
> Hmm, looks like there was a handful of other fixes as a base on this branch
> that we hadn't yet merged. Done so now, since they came in with this.

Oh OK thanks. Arnd replied earlier that he's pulling them into fixes
in the "[GIT PULL] omap fixes for v4.11-rc cycle" thread. Must have gotten
lost somewhere in the process then.

Regards,

Tony
