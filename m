From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 20 May 2013 03:26:50 +0000
Subject: [PATCH v3] clocksource: add MVF600 pit timer support
In-Reply-To: <20130520032114.GC25113@S2101-09.ap.freescale.net>
References: <1368684924-1560-1-git-send-email-b35083@freescale.com>
 <20130520022747.GA25113@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851CB223@039-SN1MPN1-003.039d.mgd.msft.net>
 <20130520032114.GC25113@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CB244@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Monday, May 20, 2013 11:21 AM
>To: Lu Jingchang-B35083
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>john.stultz at linaro.org; tglx at linutronix.de; s.hauer at pengutronix.de
>Subject: Re: [PATCH v3] clocksource: add MVF600 pit timer support
>
>On Mon, May 20, 2013 at 03:08:54AM +0000, Lu Jingchang-B35083 wrote:
>> [Lu Jingchang-B35083]
>>   I am not sure MVF5xx and MVF7xx have the same PIT block, if you have
>information that it is the same on other Vybrid SoCs, it is ok to change
>the driver name to mvf. Thanks!
>
>Even the PIT block on other Vybrid SoCs have differences from the one
>integrated on mvf600, we can handle them using device tree compatible
>string.  And that's why we need to encode SoC name in compatible.
>
[Lu Jingchang-B35083] 
  Ok, I will rename the driver and the configure option, thanks!
>> [Lu Jingchang-B35083]
>> PIT0 and PIT1 can be chained to build a 64-bit timer, so PIT2 and PIT3
>are selected as the clocksource and clockevent device, and leave PIT0 and
>PIT1 unused for anyone else who needs them. Thanks!
>
>This could be an useful info to be in the comment.
>
[Lu Jingchang-B35083] 
  I will add a comment for this, thanks!
