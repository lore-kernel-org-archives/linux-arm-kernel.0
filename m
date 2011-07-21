From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 21 Jul 2011 11:54:46 +0530
Subject: 
In-Reply-To: <CAAgF-BcTUTN5B59NO+yo7o=r=AtzvEHHOPwLBUgL15ifyYfFWA@mail.gmail.com>
References: <1311246765-4161-1-git-send-email-padma.v@samsung.com>	<4E27B914.3050809@linaro.org>
	<CAAgF-BcTUTN5B59NO+yo7o=r=AtzvEHHOPwLBUgL15ifyYfFWA@mail.gmail.com>
Message-ID: <4E27C62E.8010005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 July 2011 11:13 AM, padma venkat wrote:
> Hi Tushar,
>
> On Thu, Jul 21, 2011 at 10:58 AM, Tushar Behera
> <tushar.behera@linaro.org>  wrote:
>> On Thursday 21 July 2011 04:42 PM, Padmavathi Venna wrote:
>>>

[snip]

>>> +       gc = irq_alloc_generic_chip("s5p64x0-eint", 1, S5P_IRQ_EINT_BASE,
>>> +                                   S5P_VA_GPIO, handle_level_irq);
>>
>>                                ^^^^
> Added spaces purposefully to make the parameters aligned properly in
> the next line

But spaces should never be used for indentation.

Quoting from http://www.kernel.org/doc/Documentation/CodingStyle

"Outside of comments, documentation and except in Kconfig, spaces are 
never used for indentation"

>> nitpick: Should be TABS
>
> Thanks&Regards
> Padma

[snip]

-- 
Tushar Behera
