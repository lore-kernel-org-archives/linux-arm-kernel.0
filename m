From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 16:18:06 +0200
Subject: [GIT PULL 1/3] Rockchip ARM64 devicetree updates for 4.20 - round2
In-Reply-To: <2559110.ail6FZQ9dJ@phil>
References: <2559110.ail6FZQ9dJ@phil>
Message-ID: <CAK8P3a1EKduDFqJOsXq6W9r=0+-fyrfyTnwPeHEp1BDVRxNk_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2018 at 3:38 AM Heiko Stuebner <heiko@sntech.de> wrote:

>
> The following changes since commit 78f26da3ffbce0ea3692a89fe3f5487cb8dda068:
>
>   arm64: dts: rockchip: Add type-c port supply on rk3399-sapphire board (2018-09-10 19:16:26 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64-2
>
> for you to fetch changes up to e78d53c7b2873e0724eb765a88ccde42560b0e05:
>
>   arm64: dts: rockchip: enable display nodes on rk3328-rock64 (2018-09-28 13:18:37 +0200)
>
> ----------------------------------------------------------------
> Some additional new boards, the rk3399-based RockPro64 from Pine64, as well
> as the Vamrs Rock960. Another big feature is display support including hdmi
> and the Innosilicon hdmiphy on the rk3328, right now enabled on the rock64.
> The rock64 also got its spi-nor and spdif enabled. On the px30 we can see
> dwc2-based usb support now and finally some misc fixes, like for a new dtc
> warning, missing address and size cells and microSD fix on sapphire.

Nice to see those new boards!

What about the bugfixes though, shouldn't at least the sapphire microSD fix
be merged into 4.19 and possibly backported to stable kernels?

I've pulled this into next/dt for now, please have a look at whether we
also want some of them in the fixes branch for 4.19. Thanks,

      arnd
