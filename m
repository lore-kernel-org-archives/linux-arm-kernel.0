From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 15:05:53 +0100
Subject: [PATCH v2 0/2] ARM: move Dual-Timer SP804 driver to
 drivers/clocksource
In-Reply-To: <20150518134702.GY2067@n2100.arm.linux.org.uk>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
 <20150518134702.GY2067@n2100.arm.linux.org.uk>
Message-ID: <5559F1C1.7080206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/15 14:47, Russell King - ARM Linux wrote:
> On Mon, May 18, 2015 at 01:44:42PM +0100, Sudeep Holla wrote:
>> Since there are ARM64 platforms(e.g. Juno) with SP804 timers, we need
>> to move the driver out of arch/arm so that the code can be shared.
>>
>> Changes v1->v2:
>> 	- introduces sp804_timer_disable and retained the integrator
>> 	  and realview timer initialisation code as suggested by Russell
>>
>> v1: https://lkml.org/lkml/2015/4/30/225
>
> This looks fine to me, thanks.
>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>

Thanks Russell, I assume you are fine if it goes via clocksource(i.e.
Daniel) tree.

Regards,
Sudeep
