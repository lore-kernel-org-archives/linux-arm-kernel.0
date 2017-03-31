From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 11:57:26 +0200
Subject: [GIT PULL 3/3] Rockchip dts64 updates (using arm/arm64 symlinks)
 for 4.12 part1
In-Reply-To: <5670481.GxV7NCMtHk@phil>
References: <5178456.jWASpzTAdU@phil> <5670481.GxV7NCMtHk@phil>
Message-ID: <CAK8P3a2VB8bxEotEr1K6CTpj+hVnqwO8OcLSo0gAtepgDVe=Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 5:54 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> The following changes since commit 0a6081b673bb6aaec31771b3111dd6741c94382f:
>
>   arm64: dts: add arm/arm64 include symlinks (2017-03-21 17:21:28 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.12-rockchip-dts64-symlinks-1
>
> for you to fetch changes up to b9ed79fa91c5271ca166dfde99883ca3afb190fe:
>
>   arm64: dts: rockchip: add regulator info for Kevin digitizer (2017-03-23 00:51:58 +0100)
>
> ----------------------------------------------------------------
> Rockchip dts changes based on the newly created arm/arm64 symlinks.
> The core addition is the support for the rk3399-based Gru family of
> ChromeOS devices, like the Kevin board which is the recently released
> Samsung Chromebook Plus. Additionally the usb3 controllers are added
> to rk3399 as they're used on Gru devices and even without full type-c
> support they can at least drive usb2 devices already.
>

Pulled into next/dt64, thanks!

      Arnd
