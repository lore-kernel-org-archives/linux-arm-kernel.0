From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 05 Jun 2013 11:45:07 +0200
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <51AF06E0.6040103@keymile.com>
References: <51ADBEE0.5040500@keymile.com> <51ADC2C2.6010106@gmail.com>
 <51AE53D4.5070208@keymile.com> <51AEFF26.8080004@gmail.com>
 <51AF06E0.6040103@keymile.com>
Message-ID: <51AF08A3.6030407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geraldo,
On 06/05/2013 11:37 AM, Gerlando Falauto wrote:
> Hi Sebastian,
> 
> thanks for the info.
> 
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
> 
> Because the first one looks like it's using generic irq chip already.
> For the second one I don't understand how you can handle the per-CPU 
> registers which are peculiar to MV78200/ArmadaXP.
> Unless there's already patches on top of Thomas's rework for the per-CPU 
> registers.
> 

Currently we don't use the per-CPU register for Armada XP (I am not sure for
MV78200). it was the cause of bugs and we didn't find how to properly fix
them, so the solution was to not use the per-cpu part.

> Thank you,
> Gerlando
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
