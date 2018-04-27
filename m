From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Apr 2018 12:06:23 -0700
Subject: [PATCH 0/2] Amlogic 32-bit multi_v7_defconfig updates
In-Reply-To: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 22 Apr 2018 12:38:03 +0200")
References: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
Message-ID: <7hh8nw1nbk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Some boards come with a PMU (system power controller, such as the Ricoh
> RN5T618). These need CONFIG_I2C_MESON built-in so the regulators can be
> set up during boot.
>
> Also enable CONFIG_PWM_MESON (as module) because some boards use it to
> dim the LED and/or generate the 32.768 kHz clock for the SDIO wifi chip.
>
> @Kevin: I assume that you'll take this through your tree, so no immediate
> action from the arm-soc maintainers needed, right?

Correct.

Merged into v4.18/defconfig,

Kevin
