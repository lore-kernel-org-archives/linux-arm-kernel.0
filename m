From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 11 Oct 2017 17:20:22 -0700
Subject: [PATCH 0/2] Enable the Amlogic Meson SDIO MMC controller
In-Reply-To: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 7 Oct 2017 18:29:38 +0200")
References: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
Message-ID: <7ho9pdfc8p.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Now that the SDIO MMC driver is queued for v4.15 we need to prepare
> our platform so boards can actually use this driver.
> This adds the Meson SDIO MMC controller to the .dts files and
> enables the corresponding driver in the multi_v7_defconfig.

Just curious... were you able to test this on any meson8 platform?

[...]

> Martin Blumenstingl (2):
>   ARM: dts: meson: add the SDIO MMC controller

Applied to v4.15/dt

>   ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC controller

Applied to v4.15/defconfig

Thanks!

Kevin
