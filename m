From: jtzhou@marvell.com (Jett Zhou)
Date: Wed, 30 Nov 2011 20:54:44 -0800
Subject: [V3 0/6] rtc-sa1100 clean up
In-Reply-To: <201111301745.00327.arnd@arndb.de>
References: <1322634843-4733-1-git-send-email-jtzhou@marvell.com>
 <201111301745.00327.arnd@arndb.de>
Message-ID: <78895A20B3CF7D49B5589B604D36692B1A00D0B19A@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd

Thanks for your reminder. I will pay attention to it later.

Best Regards
Jett

-----Original Message-----
From: Arnd Bergmann [mailto:arnd at arndb.de] 
Sent: Thursday, December 01, 2011 1:45 AM
To: linux-arm-kernel at lists.infradead.org
Cc: Jett Zhou; robert.jarzmik at free.fr; a.zummo at towertech.it; haojian.zhuang at gmail.com; plagnioj at jcrosoft.com; rtc-linux at googlegroups.com
Subject: Re: [V3 0/6] rtc-sa1100 clean up

On Wednesday 30 November 2011, Jett.Zhou wrote:
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

Looks good to me, but a small note on the submission:

Please always use the --thread option to git-send-email
(with --no-chain-reply). I think this is now the default
for recent versions, and it makes it easier to see which
patches belong together.

The build fix should be submitted separately so it can
go into 3.2, while the rest ends up in 3.3.

	Arnd
