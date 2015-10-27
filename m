From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 27 Oct 2015 22:52:52 +0100
Subject: [PATCH v2 8/9] ARM: dts: Add leds support to STM32F429 Discovery
 board
In-Reply-To: <CACRpkdaQWm7Jz7Zj-amqx3EHVYi_-GvNxyQs9c8ht2WjGjAphg@mail.gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYjq9XqKM4imYsaa_HBopS7uFnbb6gf=hRZHGC4baafAg@mail.gmail.com>
 <CALszF6Bo3x4jWnvDc=28s=517YJrv2=3BuuYmxjqP4ciF17fcQ@mail.gmail.com>
 <562FEE85.3010204@suse.de>
 <CACRpkdaQWm7Jz7Zj-amqx3EHVYi_-GvNxyQs9c8ht2WjGjAphg@mail.gmail.com>
Message-ID: <562FF234.9010403@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.10.2015 um 22:46 schrieb Linus Walleij:
> Heartbeat is awesome.

Yes, it's awesome for testing, but not for a .dts file that ends up in a
distro (not the case here, of course) and keeps blinking on the desk.

If someone wants LEDs to blink, they can set that via sysfs or by
modifying their .dts locally.

sunxi chose to keep LEDs off my default. For qcom we had a similar
discussion some weeks ago. I don't regularly read Linux patches, so feel
free to skim the archives yourself.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
