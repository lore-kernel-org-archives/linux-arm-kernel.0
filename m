From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 28 Oct 2015 08:09:23 +0000
Subject: [PATCH v2 8/9] ARM: dts: Add leds support to STM32F429 Discovery
 board
In-Reply-To: <562FF234.9010403@suse.de>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-9-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYjq9XqKM4imYsaa_HBopS7uFnbb6gf=hRZHGC4baafAg@mail.gmail.com>
 <CALszF6Bo3x4jWnvDc=28s=517YJrv2=3BuuYmxjqP4ciF17fcQ@mail.gmail.com>
 <562FEE85.3010204@suse.de>
 <CACRpkdaQWm7Jz7Zj-amqx3EHVYi_-GvNxyQs9c8ht2WjGjAphg@mail.gmail.com>
 <562FF234.9010403@suse.de>
Message-ID: <563082B3.8040301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/10/15 21:52, Andreas F?rber wrote:
> Am 27.10.2015 um 22:46 schrieb Linus Walleij:
>> Heartbeat is awesome.
>
> Yes, it's awesome for testing, but not for a .dts file that ends up in a
> distro (not the case here, of course) and keeps blinking on the desk.
>
> If someone wants LEDs to blink, they can set that via sysfs or by
> modifying their .dts locally.
>
> sunxi chose to keep LEDs off my default. For qcom we had a similar
> discussion some weeks ago. I don't regularly read Linux patches, so feel
> free to skim the archives yourself.

Among the existing DTS files there is pretty significant use of 
heartbeat although its not absolute.

There are 119 files that set a default-trigger, of these 91 (~75%) 
include a line to configure a heartbeat.

Personally I'd be very happy with heartbeat by default on STM32... I've 
seldom worked on a board without a default-enabled heartbeat so they 
make me feel comfortable. ;-)


Daniel.
