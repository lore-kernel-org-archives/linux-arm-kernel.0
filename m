From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 27 Aug 2012 07:35:43 +0000
Subject: [PATCH v3 0/6] omap-am33xx rtc dt support
In-Reply-To: <50256797.3020505@ti.com>
References: <cover.1343383616.git.afzal@ti.com> <50256797.3020505@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9BA4EB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

On Sat, Aug 11, 2012 at 01:27:11, Nori, Sekhar wrote:
> On 7/27/2012 5:53 PM, Afzal Mohammed wrote:

> > This series makes rtc-omap driver DT capable, adds AM33xx
> > RTC DT support along with a few enchancments to the driver.
> > 
> > rtc-omap driver is made intelligent enough to handle kicker
> > mechanism. This helps in removing kicker mechanism support
> > done for DaVinci at platform level.
> > 
> > This has been tested on Beaglebone (AM33xx platform) and on
> > DaVinci DA850 EVM.
> > 
> > This series is based over linux-omap master and can be
> > directly applied over linux-next, except for
> > [PATCH 6/6] arm/dts: am33xx rtc node.
> > 
> > PATCH 6/6 should go through linux-omap tree and needs
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg71644.html
> > (arm/dts: am33xx wdt node) to get applied cleanly
> 
> I tested patches 1-5 on AM18x EVM using rtcwake and hwclock commands.
> Also tested on DT enabled AM18x EVM using hwclock.
> 
> For patched 1-5:
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> Alessandro,
> 
> I assume you would want me to queue 2/6 through DaVinci tree. That patch
> depends on 1/6 being accepted and merged by you. Let me know how you
> want to move forward here.

Can you please help 1-5 patches in this series to get into mainline.
1-5 of this series is a prerequisite for adding RTC support for AM335X
SoC's, which is present in beaglebone, AM335X EVM.

Also this series does cleanup on DaVinci platform by moving kicker handling
mechanism to driver. And we have Ack from DaVinci maintainer on 1-5 of this
series.

Patch 6/6 adds AM335X RTC DT support, not sure whether you can take 6/6
or Tony should be taking it.

The series applies cleanly over linux-next (now including 6/6)

Regards
Afzal
