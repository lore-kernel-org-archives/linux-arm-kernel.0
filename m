From: robherring2@gmail.com (Rob Herring)
Date: Sat, 01 Oct 2011 15:55:05 -0500
Subject: ARM SoC tree: OMAP PM dependency on tip irq/core
In-Reply-To: <87k48pfyvg.fsf@ti.com>
References: <87aa9mm8ts.fsf@ti.com> <87k48pfyvg.fsf@ti.com>
Message-ID: <4E877E29.7000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2011 05:29 PM, Kevin Hilman wrote:
> Hi Arnd,
> 
> Kevin Hilman <khilman@ti.com> writes:
> 
>> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
>> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
>> in the irq/core branch of Thomas' tip tree[3].
>>
>> In the past, I noticed you merged external trees like this to solve
>> dependencies.
>>
>> Could you pull the irq/core branch into your tree to meet this
>> dependency?
> 
> On second thought, since Santosh's branch is the only one with this
> dependency (and we also have a dependency on Russell's devel-stable)
> I'll just build up a branch for Santosh's series that includes
> rmk/devel-stable and tglx/irq-core.
> 

Any new platforms will have a dependency on rmk/devel-stable with the
mach header clean-up. I'll probably have a dependency on tglx's tree as
well.

Rob
