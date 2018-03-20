From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 20 Mar 2018 14:32:07 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.17
In-Reply-To: <7hh8pbr4kp.fsf@baylibre.com>
References: <7hh8pbr4kp.fsf@baylibre.com>
Message-ID: <CAOi56cU2PaWD87w9RrOz5qXjTYZPNN4GQxB=qd=HiGPxjJWKpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 5:08 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt
>
> for you to fetch changes up to 0793d5376b9986283e8bf9c777eb6ffda5c1b925:
>
>   ARM: dts: meson8b-odroidc1: add microSD support (2018-03-19 16:46:46 -0700)

Retracted.  Please ignore  (I've also deleted the tag)

> ----------------------------------------------------------------
> Amlogic 32-bit DT updates for v4.17
> - odroid-c1: add microSD, ethernet, USB reset
> - add reset controller
> - fix requesting GPIOs greater than GPIOZ_3
>
> ----------------------------------------------------------------
> Emiliano Ingrassia (2):
>       ARM: dts: meson8b: extend ethernet controller description
>       ARM: dts: meson8b-odroidc1: ethernet support
>
> Linus L?ssing (1):
>       ARM: dts: meson8b-odroidc1: add microSD support
>
> Martin Blumenstingl (5):
>       ARM: dts: meson8b: grow the reset controller memory zone
>       ARM: dts: meson8: add the reset controller
>       ARM: dts: meson8: add the USB reset line
>       ARM: dts: meson8b: add the I2C clocks
>       pinctrl: meson: meson8b: fix requesting GPIOs greater than GPIOZ_3

This patch is extra, and is already going through the pinctrl tree.  I
mistakenly applied the driver patch instead of the DT patch.

Respin coming right up.

Thanks to Martin Blumenstingl for pointing out my mistake.

Kevin
