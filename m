From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Mon, 4 Jun 2012 09:11:54 +0200
Subject: [PATCH v3] ARM: at91: aic can use fast eoi handler type
In-Reply-To: <20120602165000.GB14903@mudshark.cambridge.arm.com>
References: <1338545298-6687-1-git-send-email-ludovic.desroches@atmel.com>
 <20120602165000.GB14903@mudshark.cambridge.arm.com>
Message-ID: <4FCC5FBA.2030103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Le 06/02/2012 06:50 PM, Will Deacon a ?crit :
> Hi Ludovic,
>
> I have some minor corrections to the commit message but the code looks fine
> now. Thanks!
>
> On Fri, Jun 01, 2012 at 11:08:18AM +0100, ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>
>> The Advanced Interrupt Controller allows to use the fast EOI handler type.
>
> allows us to use
>
>> It lets remove the Atmel specific workaround into arch/arm/kernel/irq.c used
>
> lets us remove the Atmel specific workaround in
>

Thanks, I'll correct my commit message.

>> to indicate to the AIC the end of the interrupt treatment.
>> Removing irq_finish from handle_IRQ involves to manage it in the gpio irq
>> handler.
>
> I don't understand this final sentence. The GPIO changes are just mirroring
> the change of flow control so I don't think you need to comment on them.
>

Yes, it was what I wanted to point out. Since it seems obvious, I'll 
remove this final sentence.

>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
>
> Cheers,
>
> Will
>
>

Regards

Ludovic
