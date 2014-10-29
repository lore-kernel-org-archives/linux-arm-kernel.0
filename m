From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Oct 2014 10:22:16 +0000
Subject: [PATCH 2/3] irqchip: GIC: Add support for irq_{get,
 set}_irqchip_state
In-Reply-To: <CACRpkdZJBWF=JPksecB4UNxcYtjhybAUprhWHkdHzMpb6gchJQ@mail.gmail.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-3-git-send-email-marc.zyngier@arm.com>
 <CACRpkdZJBWF=JPksecB4UNxcYtjhybAUprhWHkdHzMpb6gchJQ@mail.gmail.com>
Message-ID: <5450BFD8.7040307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/14 10:14, Linus Walleij wrote:
> On Sat, Oct 25, 2014 at 12:14 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> Add the required hooks for the internal state of an interrupt
>> to be exposed to other subsystems.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> (...)
>> +static void gic_poke_irq(struct irq_data *d, u32 offset)
>> +static int gic_peek_irq(struct irq_data *d, u32 offset)
> 
> Awesome terminology Marc, very CBM BASIC v2 :)

Sorry Linus, I'm strictly an ORIC EXTENDED BASIC V1.0 kind of guy. :-)

	M.
-- 
Jazz is not dead. It just smells funny...
