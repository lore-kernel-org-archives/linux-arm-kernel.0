From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:41:56 +0200
Subject: [GIT PULL 4/4] Rockchip dts64 changes for 4.14
In-Reply-To: <3713539.z1Eee8O6DN@phil>
References: <12145142.47nS8LyXIe@phil> <3713539.z1Eee8O6DN@phil>
Message-ID: <CAK8P3a2=9L1Rgy_86nj1yv2o9EY+1mkivd+h0sUhcfzXAQUAmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 6, 2017 at 11:51 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> ----------------------------------------------------------------
> 64bit Rockchip devicetree changes containing fixes for pinctrl typos
> and the use of keep-power-in-suspend in non-sdio nodes as well as the
> removal of the deprecated num-slots property from dwmmc nodes.
>
> rk3328 gets support for spdif, io-domains and usb (including enablement
> of usb on the evaluation board), while rk3368 gains support for spdif.
>
> The biggest chunk of course aims for the rk3399 with a number of pcie
> changes, support for the mali gpu, a new power-domain, sdmmc support
> on the firefly board and dynamic-power-coefficients.
>
> The gru family also gets support for their quite central pwm regulators
> using the newly introduced vctrl regulator types.

Pulled into next/dt64, thanks!

       Arnd
