From: jtzhou@marvell.com (Jett Zhou)
Date: Tue, 29 Nov 2011 22:37:38 -0800
Subject: [V3 0/6] rtc-sa1100 clean up
In-Reply-To: <20111130045624.GB15008@game.jcrosoft.org>
References: <1322627186-32345-1-git-send-email-jtzhou@marvell.com>
 <20111130045624.GB15008@game.jcrosoft.org>
Message-ID: <78895A20B3CF7D49B5589B604D36692B1A00D0AE0E@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean

Sorry, I made a mistake on your email address, I sent again.

Best Regards
Jett

-----Original Message-----
From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com] 
Sent: Wednesday, November 30, 2011 12:56 PM
To: Jett Zhou
Cc: obert.jarzmik at free.fr; a.zummo at towertech.it; haojian.zhuang at gmail.com; linux-arm-kernel at lists.infradead.org; rtc-linux at googlegroups.com; plagnioj at jcrosoft.come
Subject: Re: [V3 0/6] rtc-sa1100 clean up

I did not receive you patch

can you check please

Best Regards,
J.
On 12:26 Wed 30 Nov     , Jett.Zhou wrote:
> This patch set do the following things:
>   1) clean up sa1100-rtc for support sa1100/pxa/mmp series
>   2) add dummy clock for pxa arch
>   3) clean up clock dev for sa1100 arch and add dummy clock for sa1100
>   4) fix build error for sa1100 arch
> 
> Jett.Zhou (6):
>   RTC: sa1100: Clean out ost register
>   RTC: sa1100: remove redundant code of setting alarm
>   RTC: sa1100: support sa1100, pxa and mmp soc families
>   ARM: pxa: add dummy clock for sa1100-rtc
>   ARM: sa1100: clean up of the clock support
>   ARM: sa1100: fix build error
> 
>  arch/arm/Kconfig                   |    2 +-
>  arch/arm/mach-pxa/devices.c        |   20 +++
>  arch/arm/mach-pxa/pxa25x.c         |    1 +
>  arch/arm/mach-pxa/pxa27x.c         |    1 +
>  arch/arm/mach-pxa/pxa300.c         |    1 +
>  arch/arm/mach-pxa/pxa320.c         |    1 +
>  arch/arm/mach-pxa/pxa3xx.c         |    1 +
>  arch/arm/mach-pxa/pxa95x.c         |    1 +
>  arch/arm/mach-sa1100/Makefile.boot |    4 +-
>  arch/arm/mach-sa1100/clock.c       |   91 ++++++++---
>  arch/arm/mach-sa1100/generic.c     |   20 +++
>  drivers/rtc/Kconfig                |    2 +-
>  drivers/rtc/rtc-sa1100.c           |  300 ++++++++++++++++++++++--------------
>  13 files changed, 299 insertions(+), 146 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
