From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 05 Jun 2013 11:37:36 +0200
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <51AEFF26.8080004@gmail.com>
References: <51ADBEE0.5040500@keymile.com> <51ADC2C2.6010106@gmail.com>
 <51AE53D4.5070208@keymile.com> <51AEFF26.8080004@gmail.com>
Message-ID: <51AF06E0.6040103@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

thanks for the info.

On 06/05/2013 11:04 AM, Sebastian Hesselbarth wrote:
[...]
>
> I have irqchip and clocksource drivers ready for Orion SoCs (Kirkwood,
> Dove, Orion5x, MV78x00). Just need some time to rebase and send patches.

[sorry we've moved to a different topic]
[adding Thomas Gleixner]
You mean the driver in arch/arm/plat-orion/gpio.c or the generic
one in drivers/gpio/gpio-mvebu.c?

Because the first one looks like it's using generic irq chip already.
For the second one I don't understand how you can handle the per-CPU 
registers which are peculiar to MV78200/ArmadaXP.
Unless there's already patches on top of Thomas's rework for the per-CPU 
registers.

Thank you,
Gerlando
