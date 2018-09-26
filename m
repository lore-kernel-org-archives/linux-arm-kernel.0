From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 26 Sep 2018 10:52:00 +0200
Subject: [PATCH 0/4] Meson8b: Odroid-C1 improvements
In-Reply-To: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Thu, 13 Sep 2018 22:29:15 +0200")
References: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
Message-ID: <7h8t3o63pr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This is a small collection of improvements for the Odroid-C1 board.
> My main goal is to prepare the CPU voltage regulator as I'm using
> the Odroid-C1 to test my changes which will enable CPU frequency
> scaling on Meson8/Meson8b/Meson8m2.
>
> While I was going through the schematics anyways I added more
> regulators, enabled the SAR ADC and added the /chosen/stdout-path
> property to make debugging with "earlycon" easier.
>
> schematics for the board are published by Hardkernel and can be found
> here: [0]
>
> NOTE: This series depends on my patch "ARM: dts: meson8b: add the
> I2C_A, PWM_C and UART_B pins" [1] from my other series called
> "Meson8b: add support for the Endless Mini EC-100" as this defines
> the "pwm_c1_pins" for the CPU voltage regulator (which is controlled
> via PWM).

Applied to v4.20/dt (on top of the Endless series)

Thanks for pointing out the dependencies,

Kevin
