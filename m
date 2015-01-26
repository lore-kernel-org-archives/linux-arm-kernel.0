From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 26 Jan 2015 15:55:01 +0100
Subject: [GIT PULL] ARM: mediatek: arm64 changes for v3.20
In-Reply-To: <CABuKBeLPAHkKZ-1wYDgnWK6FxCq=EQerw_PLbThJkf6JmhgH8Q@mail.gmail.com>
References: <CABuKBeLPAHkKZ-1wYDgnWK6FxCq=EQerw_PLbThJkf6JmhgH8Q@mail.gmail.com>
Message-ID: <CABuKBeJgHmBYbnJpBGVmXth9wy+JowxuTDci58F7YqXpUq_sew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, hi Arnd,

2015-01-26 13:37 GMT+01:00 Matthias Brugger <matthias.bgg@gmail.com>:
> Hi Arnd and Olof,
>
> Please take the following arm64 patches for v3.20.

I somehow screwed up this pull request. Please ignore it.

Cheers,
Matthias

>
> Cheers,
> Matthias
>
> ---
>
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>
> are available in the git repository at:
>
>   https://github.com/mbgg/linux-mediatek.git tags/v3.20-next-arm64
>
> for you to fetch changes up to 4727a6f631bf3ab2a0373acd27d40483446fcb8a:
>
>   arm64: mediatek: Add MT8173 SoC Kconfig and defconfig (2015-01-26
> 13:26:48 +0100)
>
> ----------------------------------------------------------------
> Add support for mt8173 SoC from Mediatek.
>
> - add DT bindings documentation
> - add dts files for SoC and evaluation board
> - add to Kconfig and defconfig
>
> ----------------------------------------------------------------
> Eddie Huang (3):
>       Document: DT: Add bindings for mediatek MT8173 SoC Platform
>       arm64: dts: Add mediatek MT8173 SoC and evaluation board dts and Makefile
>       arm64: mediatek: Add MT8173 SoC Kconfig and defconfig
>
>  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
>  .../bindings/arm/mediatek/mediatek,sysirq.txt      |   1 +
>  .../devicetree/bindings/serial/mtk-uart.txt        |   4 +-
>  arch/arm64/Kconfig                                 |   6 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/mediatek/Makefile              |   5 +
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  38 +++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 168 +++++++++++++++++++++
>  arch/arm64/configs/defconfig                       |   2 +
>  9 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi



-- 
motzblog.wordpress.com
