From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 May 2012 13:27:07 +0200
Subject: [PATCH 08/15] ARM: ux500: PRCMU related configuration and layout
 corrections for Device Tree
In-Reply-To: <4FAA469B.2030200@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdanU4eWhRobxzBV1mcU5T6QLCrWfBAczRFtn6gguhRNng@mail.gmail.com>
 <4FAA469B.2030200@linaro.org>
Message-ID: <CACRpkda-H5+-TavXheGHqpY+ZxzQoJV17vtp+CWutzZ8f1pHOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 12:27 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On 09/05/12 09:53, Linus Walleij wrote:
>>
>> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org> ?wrote:
>>
>>> Apply db8500 related PRCMU Device Tree settings and clean up some
>>> formatting
>>> errors. We also remove one of the PRCMU assigned IRQs, as it is currently
>>> not
>>> used.
>>>
>>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>>
>> (...)
>>>
>>> - ? ? ? ? ? ? ? ? ? ? ? interrupts =<46 47>;
>>> + ? ? ? ? ? ? ? ? ? ? ? interrupts =<0 47 0x4>;
>>
>>
>> Sorry I don't get it, why is two values in decimal and one in hex?
>>
>> Please choose one and stick to it...
>
> Because the one on the end is a mask.
>
> <[PPI|SPI] [IRQ Number] [Configuration mask]>

...and I guess there must be a precedent for using hex only
for any mask value. OK then, I'm not a DT person anyway.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
