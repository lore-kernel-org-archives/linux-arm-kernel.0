From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 14:03:24 -0700
Subject: [GIT PULL 2/3] omap platform and board related late patches for
 v3.7 merge window
In-Reply-To: <20120925033136.GS28835@atomide.com>
References: <pull-1348521952-285145> <E1TGGAI-0000D1-T0@merlin.infradead.org>
 <20120925003953.GQ28835@atomide.com>
 <20120925033136.GS28835@atomide.com>
Message-ID: <20120929210324.GC12999@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 08:31:36PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120924 17:41]:
> > * Tony Lindgren <tony@atomide.com> [120924 14:30]:
> > > The following changes since commit 0e70156de4c8465bfb8cb45cdc1bbc2fa474ce14:
> > > 
> > >   ARM: OMAP2+: Make omap4-keypad.h local (2012-09-20 15:04:04 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-board-late-v2-for-v3.7
> > > 
> > > for you to fetch changes up to ead53717d9ab28c942b9adf66f8c02442dbfbc8a:
> > > 
> > >   arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX (2012-09-24 10:32:39 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > These board and platform related patches have been posted
> > > quite a while ago but have somehow fallen though the cracks
> > > as most of the focus has been making things to work with
> > > device tree. As the first patch depends on sparse IRQ
> > > related removal of irqs.h and related header moves, these
> > > are based on omap-cleanup-local-headers-for-v3.7 tag.
> > 
> > Let's scrap this pull request, Russell noted that Yegor's patch
> > breaks sa1111.
> 
> Here's the updated pull request with just the top patch dropped.
> 
> Tony
> 
> 
> The following changes since commit 0e70156de4c8465bfb8cb45cdc1bbc2fa474ce14:
> 
>   ARM: OMAP2+: Make omap4-keypad.h local (2012-09-20 15:04:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-board-late-v3-for-v3.7

Thanks, pulled this on top of the previous cleanup-headers.

In the future, feel free to remove the tag that you don't want me to pull from
the repo so I don't accidentally pull it anyway.


-Olof
