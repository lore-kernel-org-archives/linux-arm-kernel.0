From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 5 Feb 2015 17:22:40 +0400
Subject: [PATCH v2 0/5] ARM: sa1100: implement irq driver as proper
 irqchip driver
In-Reply-To: <CACRpkdbstAkL0Tyt6UHrzwkccMteOehoPwGROJxoUbpDJ1yxjg@mail.gmail.com>
References: <1422648066-7897-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdbstAkL0Tyt6UHrzwkccMteOehoPwGROJxoUbpDJ1yxjg@mail.gmail.com>
Message-ID: <CALT56yPLS-OAuZ1ipt3jKWPSH6W0Nc7qOBmRMcgugEhPYXOCFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2015-02-04 15:19 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Jan 30, 2015 at 9:01 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> This is a second attempt to move Intel StrongARM SA-11x0 IRQ driver
>> to drivers/irqchip/ place.
>>
>> Changes since V1:
>>
>>  - Added soc/sa1100/pwer.h header containing sa11x0_*_set_wake()
>>    prototypes.
>>
>>  - Removed spinlock from mask/unmask functions
>>
>>  - Minor whitespace changes.
>>
>> The patches are based on my previous sa1100 patches that can be found
>> in Russell's for-next branch or in linux-next tree.
>
> I have applied it and tested on the Compaq iPaq h3600:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thank you. I'll probably wait for a couple more days for more feedback.
Especially from IRQ CHIP maintainers.

Thomas, Jason: any feedback on this version? If no, can you ack it
so that the patches can be merged through Russell's tree? If so, I
can maybe squash last two patches, so that the new driver will
be tied to old one through git internals?

Russell:any comments from your side?

>
> Very nice to see the SC and GPIO offsets in /proc/interrupts
> and very clean code, good work!

-- 
With best wishes
Dmitry
