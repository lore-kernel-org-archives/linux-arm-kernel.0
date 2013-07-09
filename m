From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jul 2013 23:16:20 +0200
Subject: [PATCH V3 2/3] clocksource: mmp: support CLOCKSOURCE OF DECLARE
In-Reply-To: <20130709181434.76f6216d@skate>
References: <1373352166-10064-1-git-send-email-zhangwm@marvell.com>
 <1373352166-10064-3-git-send-email-zhangwm@marvell.com>
 <20130709181434.76f6216d@skate>
Message-ID: <201307092316.20905.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013, Thomas Petazzoni wrote:
> Dear Neil Zhang,
> 
> On Tue, 9 Jul 2013 14:42:45 +0800, Neil Zhang wrote:
> > support CLOCKSOURCE OF DECLARE for mmp timer.
> > 
> > Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> > ---
> >  arch/arm/mach-mmp/mmp-dt.c  |    5 ++---
> >  arch/arm/mach-mmp/mmp2-dt.c |    3 +--
> >  arch/arm/mach-mmp/time.c    |   15 ++-------------
> >  3 files changed, 5 insertions(+), 18 deletions(-)
> 
> Maybe it would be good to take this opportunity to move
> arch/arm/mach-mmp/time.c into drivers/clocksource/.

+1

Or we might want to have a more coordinated move of all clocksource
drivers in arch/arm to drivers/clocksource now, as we have done for some
other subsystems.

	Arnd
