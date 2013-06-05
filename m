From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 05 Jun 2013 11:49:04 +0200
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <51AF06E0.6040103@keymile.com>
References: <51ADBEE0.5040500@keymile.com> <51ADC2C2.6010106@gmail.com>
 <51AE53D4.5070208@keymile.com> <51AEFF26.8080004@gmail.com>
 <51AF06E0.6040103@keymile.com>
Message-ID: <51AF0990.7090406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/13 11:37, Gerlando Falauto wrote:
> On 06/05/2013 11:04 AM, Sebastian Hesselbarth wrote:
> [...]
>>
>> I have irqchip and clocksource drivers ready for Orion SoCs (Kirkwood,
>> Dove, Orion5x, MV78x00). Just need some time to rebase and send patches.
>
> [sorry we've moved to a different topic]
> [adding Thomas Gleixner]
> You mean the driver in arch/arm/plat-orion/gpio.c or the generic
> one in drivers/gpio/gpio-mvebu.c?

For Kirkwood and Dove, DT kernels use gpio-mvebu. And that is there
from a time when there was no irqdomain support in generic chip. That
should be updated.

Sebastian
