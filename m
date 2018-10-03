From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 3 Oct 2018 11:05:25 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.20
In-Reply-To: <CAK7LNAQnPeNwmmKL_BWSnzEsUCq+MW+5c2TXWnuszOBi32iybg@mail.gmail.com>
References: <CAK7LNAQnPeNwmmKL_BWSnzEsUCq+MW+5c2TXWnuszOBi32iybg@mail.gmail.com>
Message-ID: <CAK7LNATVRmQ5n6F5zdCD53kkiaK110Rx734Tm=YLihFQBEwbLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,


Please hold on.

I've received a little more patches.

I will queue up them, and send a respin later on.

Thanks.


On Wed, Oct 3, 2018 at 8:47 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd, Olof,
>
> Please pull UniPhier DT updates for the v4.20 MW.
>
> In this cycle, I queued up all arm/arm64 changes
> into a single branch to avoid build errors.
>
> Thanks!
>
>
>
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.20
>
> for you to fetch changes up to 84a9c4d55907feece68c6012d3c030cf5c841ceb:
>
>   arm64: dts: uniphier: add SD controller nodes (2018-10-03 08:21:27 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.20
>
> - Add more clocks to NAND controller nodes
>
> - Add SPI controller nodes
>
> - Add SD controller nodes
>
> ----------------------------------------------------------------
> Kunihiko Hayashi (3):
>       ARM: dts: uniphier: add SPI pin-mux node
>       ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
>       arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3
>
> Masahiro Yamada (4):
>       ARM: uniphier: dts: add more clocks to Denali NAND controller node
>       arm64: uniphier: dts: add more clocks to Denali NAND controller node
>       ARM: dts: uniphier: add SD/eMMC controller nodes
>       arm64: dts: uniphier: add SD controller nodes
>
>  arch/arm/boot/dts/uniphier-ld4-ref.dts            |  4 ++
>  arch/arm/boot/dts/uniphier-ld4.dtsi               | 48 ++++++++++++++-
>  arch/arm/boot/dts/uniphier-ld6b-ref.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-pinctrl.dtsi           | 25 ++++++++
>  arch/arm/boot/dts/uniphier-pro4-ace.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-pro4-ref.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-pro4-sanji.dts         |  4 ++
>  arch/arm/boot/dts/uniphier-pro4.dtsi              | 62 +++++++++++++++++++-
>  arch/arm/boot/dts/uniphier-pro5.dtsi              | 59 ++++++++++++++++++-
>  arch/arm/boot/dts/uniphier-pxs2-gentil.dts        |  4 ++
>  arch/arm/boot/dts/uniphier-pxs2-vodka.dts         |  4 ++
>  arch/arm/boot/dts/uniphier-pxs2.dtsi              | 59 ++++++++++++++++++-
>  arch/arm/boot/dts/uniphier-sld8-ref.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-sld8.dtsi              | 48 ++++++++++++++-
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi  | 25 +++++++-
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi  | 61 ++++++++++++++++++-
>  .../boot/dts/socionext/uniphier-pxs3-ref.dts      |  4 ++
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi  | 43 +++++++++++++-
>  18 files changed, 458 insertions(+), 8 deletions(-)
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
