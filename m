From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 21:38:08 +0100
Subject: [GIT PULL 2/2] Rockchip dts64 changes for 4.16
In-Reply-To: <2062410.Qz0JYku65n@phil>
References: <2013174.TmhWXT9G0E@phil> <2062410.Qz0JYku65n@phil>
Message-ID: <CAK8P3a3sGWdPDVbFUh4ebZT2EnOHGMDg6nSNAu9xeyaZ8yLnEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 7:31 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.16-rockchip-dts64-1
>
> for you to fetch changes up to 13bc2c0a6a14f430abaa6a859792418644b7febd:
>
>   arm64: dts: rockchip: Add efuse device node for RK3328 SoC (2017-12-20 13:12:13 +0100)
>
> ----------------------------------------------------------------
> General RK3399 gets Mipi nodes, fixes for usb3 support and better support
> for the type-c phys. The Kevin Chromebooks based on rk3399 now can use their
> internal edp displays. RK3328 gets its efuse node and Mali450 gpu node,
> which actually produces already some nice results with the WIP Lima driver.

Pulled into next/dt, thanks!

        Arnd
