From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 09 May 2012 11:27:39 +0100
Subject: [PATCH 08/15] ARM: ux500: PRCMU related configuration and layout
 corrections for Device Tree
In-Reply-To: <CACRpkdanU4eWhRobxzBV1mcU5T6QLCrWfBAczRFtn6gguhRNng@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdanU4eWhRobxzBV1mcU5T6QLCrWfBAczRFtn6gguhRNng@mail.gmail.com>
Message-ID: <4FAA469B.2030200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/12 09:53, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Apply db8500 related PRCMU Device Tree settings and clean up some formatting
>> errors. We also remove one of the PRCMU assigned IRQs, as it is currently not
>> used.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> (...)
>> -                       interrupts =<46 47>;
>> +                       interrupts =<0 47 0x4>;
>
> Sorry I don't get it, why is two values in decimal and one in hex?
>
> Please choose one and stick to it...

Because the one on the end is a mask.

<[PPI|SPI] [IRQ Number] [Configuration mask]>


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
