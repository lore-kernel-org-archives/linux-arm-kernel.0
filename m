From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 13 Feb 2016 18:14:14 +0100
Subject: [PATCH v4 4/9] pinctrl: Add STM32 MCUs support
In-Reply-To: <CACRpkdY1E9rLwG-aXWSB7d32rhvmng+4QbVX7E0WR6aqP0oFaw@mail.gmail.com>
References: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1452773795-24216-5-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdaBcP6fC5Oxn+d1WPdHq1FtwMkf8Ap5VDLQFg-5UwEBAw@mail.gmail.com>
 <2151471.Wut3mQ9SS7@wuerfel>
 <CALszF6DTpcU8jFwA0HL8LpkxfO5ZOdFmpHBUxA7WfYgAj_uFhg@mail.gmail.com>
 <56AF4AEB.40109@st.com>
 <CACRpkdY1E9rLwG-aXWSB7d32rhvmng+4QbVX7E0WR6aqP0oFaw@mail.gmail.com>
Message-ID: <56BF6466.90104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/13/2016 03:48 PM, Linus Walleij wrote:
> On Mon, Feb 1, 2016 at 1:09 PM, Maxime Coquelin <maxime.coquelin@st.com> wrote:
>> On 02/01/2016 11:39 AM, Maxime Coquelin wrote:
>>> 2016-02-01 11:21 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>
>>>> drivers/pinctrl/stm32/pinctrl-stm32.c:26:47: fatal error:
>>>> dt-bindings/pinctrl/pinctrl-stm32.h: No such file or directory
>>>
>>> Right, I missed to notify this dependency to Linus, sorry about that.
>>> This dependency is no more needed, so I could just move the macros to
>>> the driver side.
>>>
>>> Note that I also noticed a breakage at build time due to field
>>> renaming in gpio_chip structure (dev -> parent).
>>>
>>> I propose to rebase the series and move the defines into the driver.
>>> Is it ok for you?
>>>
>> I have rebased the series, taking care to fix the mentioned problems.
>>
>> Linus, do you confirm you will revert STM32 pinctrl patches from your tree?
>
> I guess the other fixes removes the need to do this.
Exactly, all should be fine now.

>
> Sorry for not staying on top of this issue, I was swamped with mail
> and had a hard time prioritizing :(

No worries!

Thanks,
Maxime
