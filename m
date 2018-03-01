From: radoslaw.pietrzyk@gmail.com (=?UTF-8?Q?Rados=C5=82aw_Pietrzyk?=)
Date: Thu, 1 Mar 2018 22:24:21 +0100
Subject: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio
 irqchip
In-Reply-To: <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
 <CACRpkdbmmx7y3xJOOy0Dx62tMonkCgZeVzKYzr1B362QZe0fsA@mail.gmail.com>
Message-ID: <CAFvLkMRRWZKqChFu+7yEDURtM_ZmmB1RMjj8yUwTZndiwySckA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't know if Alexandre agrees but It might be better to take v2
where irq_ack is added.

2018-03-01 22:04 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Feb 21, 2018 at 2:50 PM, Radoslaw Pietrzyk
> <radoslaw.pietrzyk@gmail.com> wrote:
>
>>         - removes unneeded irq_chip.irq_eoi callback
>>         - adds irq_chip.irq_set_wake callback for possible
>>         in the future GPIO wakeup
>>
>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>
> Patch applied with Alexandre's ACK, stripping ARM from the
> commit message, thanks!
>
> Yours,
> Linus Walleij
