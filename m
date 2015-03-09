From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:47:40 +0100
Subject: [PATCH 14/14] MAINTAINERS: Add entry for STM32 MCUs
In-Reply-To: <CALszF6Bz978KA1DAxcKtmA55X=vJWEcVDa9fLOF=uNatYS+b+Q@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1423763164-5606-15-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdaM0BwMcq77MO=0-dVaqwobD5Pt+11j7ZZ4c3yKM=AkeA@mail.gmail.com>
 <CALszF6Bz978KA1DAxcKtmA55X=vJWEcVDa9fLOF=uNatYS+b+Q@mail.gmail.com>
Message-ID: <CACRpkdaYVyH-y19yHYp2noq6VhDVJYQfqkevDtLr-7y8gVwdXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 10:55 AM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> 2015-03-06 10:03 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Thu, Feb 12, 2015 at 6:46 PM, Maxime Coquelin
>> <mcoquelin.stm32@gmail.com> wrote:
>>
>>> Add a MAINTAINER entry covering all STM32 machine and drivers files.
>>>
>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> (...)
>>> +F:     drivers/clocksource/arm_system_timer.c
>>
>> Is that all? And that is not even a STM32 specific driver.
>
> For the ARM System Timer, I'm fine to add a new entry.
> Or remove the line, and let the maintain-ship to clocksource maintainers.
>
> All the STM32 files are covered by this line:
> +N:     stm32

Aha you're right, news2me, I'm old and stupid :/

Thanks,
Linus Walleij
