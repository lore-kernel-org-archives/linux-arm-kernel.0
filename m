From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 28 Nov 2018 16:57:26 -0800
Subject: [PATCH v3 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
Message-ID: <7htvk0bszt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clocks frequencies.
> The precision is determined by stepping into the duration until the counter
> overflows.
> The debugfs shows a pretty summary and each clock can be measured
> individually aswell.
>
> This patchset includes the dt-bindings, driver and the DT node added to the
> meson-gx dtsi.

Queued for v4.21...

[...]

> Neil Armstrong (3):
>   dt-bindings: amlogic: Add Internal Clock Measurer bindings
>   soc: amlogic: Add Meson Clock Measure driver

...on branch v4.21/drivers and...

>   ARM64: dts: meson-gx: Add Internal Clock Measurer node

...on branch v4.21/dt64,

Thanks,

Kevin
