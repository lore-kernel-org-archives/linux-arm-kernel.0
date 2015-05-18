From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 16:32:45 +0100
Subject: [PATCH v2 0/2] ARM: move Dual-Timer SP804 driver to
 drivers/clocksource
In-Reply-To: <alpine.DEB.2.11.1505181633470.4225@nanos>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
 <alpine.DEB.2.11.1505181633470.4225@nanos>
Message-ID: <555A061D.6030401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 18/05/15 15:34, Thomas Gleixner wrote:
> On Mon, 18 May 2015, Sudeep Holla wrote:
>
>> Since there are ARM64 platforms(e.g. Juno) with SP804 timers, we need
>> to move the driver out of arch/arm so that the code can be shared.
>>
>> Changes v1->v2:
>> 	- introduces sp804_timer_disable and retained the integrator
>> 	  and realview timer initialisation code as suggested by Russell
>
> Please route this through ARM with my ACK.
>

I have put the patches in your patch system with tglx ack
(8365/1 & 8366/1)

Regards,
Sudeep
