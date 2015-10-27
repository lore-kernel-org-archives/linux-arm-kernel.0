From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 27 Oct 2015 22:37:09 +0100
Subject: [PATCH v2 8/9] ARM: dts: Add leds support to STM32F429 Discovery
 board
In-Reply-To: <CALszF6Bo3x4jWnvDc=28s=517YJrv2=3BuuYmxjqP4ciF17fcQ@mail.gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYjq9XqKM4imYsaa_HBopS7uFnbb6gf=hRZHGC4baafAg@mail.gmail.com>
 <CALszF6Bo3x4jWnvDc=28s=517YJrv2=3BuuYmxjqP4ciF17fcQ@mail.gmail.com>
Message-ID: <562FEE85.3010204@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.10.2015 um 21:31 schrieb Maxime Coquelin:
> 2015-10-26 14:41 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>> Usually people also want to add a default linux,trigger to these,
>> like linux,default-trigger = "heartbeat"; but whatever you prefer.
> 
> Makes sense, I will add default trigger in next version.

Previously, consensus seemed to be not to use heartbeat as default, but
rather off or on.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
