From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 28 Nov 2018 16:30:19 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to
 built-in
In-Reply-To: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
Message-ID: <7hh8g0d8tg.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
> voltage supply of the CPU cores (this regulator is typically called
> "VCCK").
> Now that we are preparing support for CPU frequency scaling on Meson8,
> Meson8b and Meson8m2 we should build the pwm-meson driver into the
> kernel so we can configure the CPU voltage early in the boot process.

Can you explain a little more why the configuration of CPU voltage
cannot wait a bit so this could be properly probed?

Kevin
