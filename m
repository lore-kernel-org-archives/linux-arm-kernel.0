From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 22:46:03 +0100
Subject: [PATCH v2 8/9] ARM: dts: Add leds support to STM32F429 Discovery
 board
In-Reply-To: <562FEE85.3010204@suse.de>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYjq9XqKM4imYsaa_HBopS7uFnbb6gf=hRZHGC4baafAg@mail.gmail.com>
 <CALszF6Bo3x4jWnvDc=28s=517YJrv2=3BuuYmxjqP4ciF17fcQ@mail.gmail.com>
 <562FEE85.3010204@suse.de>
Message-ID: <CACRpkdaQWm7Jz7Zj-amqx3EHVYi_-GvNxyQs9c8ht2WjGjAphg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 10:37 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 27.10.2015 um 21:31 schrieb Maxime Coquelin:
>> 2015-10-26 14:41 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>>> Usually people also want to add a default linux,trigger to these,
>>> like linux,default-trigger = "heartbeat"; but whatever you prefer.
>>
>> Makes sense, I will add default trigger in next version.
>
> Previously, consensus seemed to be not to use heartbeat as default, but
> rather off or on.

Which consensus, where, and for whom?

Heartbeat is awesome.

Yours,
Linus Walleij
