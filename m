From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 7 Oct 2012 15:09:19 +0200
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121007040128.GA15898@kroah.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <17531317.3PGnt12jPY@vostro.rjw.lan>
 <20121007040128.GA15898@kroah.com>
Message-ID: <20121007130919.GA12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:01 Sat 06 Oct     , Greg Kroah-Hartman wrote:
> On Sun, Oct 07, 2012 at 12:18:21AM +0200, Rafael J. Wysocki wrote:
> > On Saturday 06 of October 2012 18:14:29 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > Hi,
> > > 
> > > The following changes since commit 5f3d2f2e1a63679cf1c4a4210f2f1cc2f335bef6:
> > > 
> > >   Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2012-10-06 03:16:12 +0900)
> > > 
> > > are available in the git repository at:
> > > 
> > > 
> > >   git://git.jcrosoft.org/linux-2.6.git tags/pm_suspend_standby_mem
> > > 
> > > for you to fetch changes up to b73c8f97aa8e720bd3b921159687d00626c99d63:
> > > 
> > >   arm: at91: drop at91_suspend_entering_slow_clock (2012-10-06 18:06:25 +0800)
> > > 
> > > ----------------------------------------------------------------
> > > pm: add suspend_mem and suspend_standby support
> > > 
> > > Today when we go to suspend we can not knwon at drivers level if we go in
> > > STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
> > > suspend_standby.
> > 
> > No way. Device drivers shouldn't be concerned about that.
> > 
> > > If a bus or drivers does not need to care about this distinction we fallback to
> > > suspend. This will allow to do not update the current bus or drivers.
> > > 
> > > This is needed as example by at91 OHCI, UDC and atmel serial
> > 
> > I wonder why.
> 
> Yes, that's odd, please post the patches, I don't take random git pull
> requests, sorry.
the patch did not follow the first e-mail do not why I've already resend them
this afternoon

sorry

Best Regards
J.
