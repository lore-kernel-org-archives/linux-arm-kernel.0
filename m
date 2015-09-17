From: slash.tmp@free.fr (Mason)
Date: Thu, 17 Sep 2015 18:53:15 +0200
Subject: Recent GIC v1 patch
In-Reply-To: <yw1xmvwlt48g.fsf@unicorn.mansr.com>
References: <55FAE26A.9040609@free.fr> <yw1xmvwlt48g.fsf@unicorn.mansr.com>
Message-ID: <55FAEFFB.9000905@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/2015 18:11, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> Hello Thomas, Marc,
>>
>> Mans pointed me to a recent patch of yours.
>> irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag
>> Get rid of the handler_data abuse.
>>
>> I'm using a Cortex A9 based SoC. The platform's interrupt
>> controller is cascaded into the GIC. I've been trying to
>> get this to work for two weeks with no success.
>>
>> Details can be found here:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/440327
>>
>> Do you think your patch my help with my situation?
> 
> Just try it and we'll know soon enough.

I'll do that first thing tomorrow, but I wanted to bootstrap
the process, in case someone in a different time zone could
provide some insight.

By the way, am I using a unique setup?

Platform intc -> GICv1 -> Cortex A9

Must be quite common, I don't see why I would hit a rare
bug with a common setup...

Regards.
