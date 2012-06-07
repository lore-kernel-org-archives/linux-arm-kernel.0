From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 7 Jun 2012 09:25:03 +0200
Subject: [PATCH 1/4] ARM: at91: at91 based machines specify their own
 irq handler at run time
In-Reply-To: <20120606094748.GA26504@taskit.de>
References: <1338907664-24646-1-git-send-email-ludovic.desroches@atmel.com>
 <1338907664-24646-2-git-send-email-ludovic.desroches@atmel.com>
 <20120606094748.GA26504@taskit.de>
Message-ID: <4FD0574F.6000200@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On 06/06/2012 11:47 AM, Christian Glindkamp wrote:
> On 2012-06-05 16:47, ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>
>> SOC_AT91SAM9 selects MULTI_IRQ_HANDLER in order to let machines specify their
>> own IRQ handler at run time.
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
>> ---
>>   arch/arm/mach-at91/board-cpu9krea.c           |    1 +
>>   arch/arm/mach-at91/board-sam9g20ek.c          |    1 +
>>   arch/arm/mach-at91/board-sam9261ek.c          |    1 +
>>   arch/arm/mach-at91/board-stamp9g20.c          |    1 +
>>   arch/arm/mach-at91/board-usb-a926x.c          |    1 +
>
> At least these board files contain more than one MACHINE_START, but
> you only update the last one. Same for the third patch.

Thanks for your feedback, I'll correct it in V2.

>
> I have not looked at the rest of the patch.
>
>

Regards

Ludovic
