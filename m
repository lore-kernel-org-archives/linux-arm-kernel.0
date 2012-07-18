From: johnstul@us.ibm.com (John Stultz)
Date: Wed, 18 Jul 2012 16:51:23 -0700
Subject: [PATCH v9 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <50074B32.8090607@us.ibm.com>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341588221-3822-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50074B32.8090607@us.ibm.com>
Message-ID: <50074BFB.1060708@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 04:48 PM, John Stultz wrote:
> On 07/06/2012 08:23 AM, Thomas Petazzoni wrote:
>> From: Gregory Clement <gregory.clement@free-electrons.com>
>>
>> Timer 0 is used as free-running clocksource, while timer 1 is used as
>> clock_event_device.
>
> I don't see the any clocksource in this patch.  Why is this tagged 
> clocksource?

Whoops. Now of course I see the clocksource_mmio_init().  Hrmm..

> I'm also not a huge fan of adding clockevent drivers to 
> drivers/clocksource/.

Still have mixed feelings on this point.

thanks
-john
