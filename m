From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 29 Oct 2017 16:31:55 +0100
Subject: [PATCH v7 0/6] SMP and CPU hotplug support for Meson8/Meson8b
In-Reply-To: <20170917164523.6970-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 17 Sep 2017 18:45:17 +0200")
References: <20170917164523.6970-1-martin.blumenstingl@googlemail.com>
Message-ID: <7hwp3eug0k.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This patchset adds support for booting the secondary CPU cores (and
> taking them offline again) on Amlogic Meson8 and Meson8b SoCs.
> It is based on an earlier version from Carlo Caione - this helped me
> a lot to get a better understanding of how SMP/CPU hotplug works
> (compared to the code found in Amlogic's GPL kernel sources from
> year 2015).

[...]

> Carlo Caione (2):
>   dt-bindings: Amlogic: Add Meson8 and Meson8b SMP related documentation
>   ARM: dts: meson8b: add support for booting the secondary CPU cores

Applied to v4.15/dt...

> Martin Blumenstingl (4):
>   ARM: smp_scu: add a helper for powering on a specific CPU
>   ARM: smp_scu: allow the platform code to read the SCU CPU status
>   ARM: meson: Add SMP bringup code for Meson8 and Meson8b
>   ARM: dts: meson8: add support for booting the secondary CPU cores

Applied to v4.15/soc with Russell's ack.

Thanks,

Kevin
