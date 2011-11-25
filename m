From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2011 17:19:38 +0000
Subject: [V1 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <CAN1soZzfN2aNNH5Hmuv79Y-u-GR2Mnfh3oR2D2QWZNFV6-N+YQ@mail.gmail.com>
References: <1322219217-1866-1-git-send-email-jtzhou@marvell.com>
 <201111251505.29823.arnd@arndb.de>
 <CAN1soZzfN2aNNH5Hmuv79Y-u-GR2Mnfh3oR2D2QWZNFV6-N+YQ@mail.gmail.com>
Message-ID: <201111251719.39636.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 November 2011, Haojian Zhuang wrote:
> On Fri, Nov 25, 2011 at 11:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 25 November 2011, Jett.Zhou wrote:
> >> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> >> almost the same, so re-arch the rtc-sa1100 to support them.
> >>
> >> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> >> ---
> >>  arch/arm/mach-pxa/devices.c    |   20 +++
> >>  arch/arm/mach-sa1100/generic.c |   20 +++
> >>  drivers/rtc/Kconfig            |    2 +-
> >>  drivers/rtc/rtc-sa1100.c       |  276 ++++++++++++++++++++++++++++------------
> >>  4 files changed, 238 insertions(+), 80 deletions(-)
> >
> > I looked through the series and found nothing to complain about ;-)
> >
> > Excellent cleanup!
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> >
> How about merging this patch series into arch-pxa git tree?
> 

I could do that with an Ack from Alessandro, but normally it should
go through his tree. I guess it should also go through the rtc-linux
mailing list, though I don't know how active that is.

	Arnd
