From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Nov 2010 14:49:21 -0200
Subject: [patch 1/1] iMX51: introduce MX51_GPIO_NR
In-Reply-To: <20101122224526.987309475@rtp-net.org>
References: <20101122224526.987309475@rtp-net.org>
Message-ID: <AANLkTi=Q=UOSUoJ40ThyyyDqMoC849W-cn36CkVFxKhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

2010/11/22 Arnaud Patard <arnaud.patard@rtp-net.org>:
> Currently, to define a GPIO number, we're using something like :
>
> #define EFIKAMX_PCBID0 ? ? ? ? (2*32 + 16)
>
> to define GPIO 3 16.
>
> This is not really readable and it's error prone imho (note the 3 vs 2).
> So, I'm introducing a new macro to define this in a better way. Now, the
> code sample become :
>
> #define EFIKAMX_PCBID0 ? ? ? ? MX51_GPIO_NR(3, 16)

Can you rename the macro to MX5x_GPIO_NR instead of MX51_GPIO_NR?

This way we can also use this macro for MX53 and MX508 when they show
up in mainline.

Regards,

Fabio Estevam
