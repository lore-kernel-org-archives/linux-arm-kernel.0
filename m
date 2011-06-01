From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 1 Jun 2011 16:04:53 +0800
Subject: [RFC] Consolidation: Replace all led drivers in arch/arm to leds
	trigger drivers
In-Reply-To: <BANLkTikZ4bo8_MO68SZSyAeFdZVLJkAnkw@mail.gmail.com>
References: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
	<BANLkTikZ4bo8_MO68SZSyAeFdZVLJkAnkw@mail.gmail.com>
Message-ID: <BANLkTinfRym4=sv-GtzcE1uE2Zhgib6bGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 4:00 PM, Andrew Victor <avictor.za@gmail.com> wrote:
> hi Bryan,
>
>> arch/arm/mach-at91/leds.c
>
> That file also has common initialization & registration code for the
> "leds-gpio" and "leds-atmel-pwm" devices, but the old CONFIG_LEDS
> section can be dropped.
>
>
>> Or we can just delete some leds driver such as
>> arch/arm/mach-ks8695/leds.c, since nobody is using that driver in
>> ks8695.
>
> That file can be deleted, and also drop the ks8695_init_leds() from
> arch/arm/mach-ks8695/devices.c.
>
>

Thanks Andrew, I will provide 2 patches soon.

-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
