From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Oct 2016 11:02:23 +0800
Subject: [PATCH 0/6] ARM: sun5i: chip: Misc improvements
In-Reply-To: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
References: <cover.92d041a0a6fe40f1c8839cabb70247445eaffdfb.1476704881.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65L=Cf1EWgZ1YPyFA_g7aiqAGwNkC-e0vs3OM8BJ2OEbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 7:48 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> This is a bunch of patches I gathered for the CHIP, that enables a few
> things, like the WiFi regulators (and its associated power sequence), a few
> optional buses, etc.

FYI this series makes more sense if you mention the Pocket CHIP DT overlays.

ChenYu

>
> Let me know what you think,
> Maxime
>
> Antoine Tenart (1):
>   ARM: sun5i: chip: add a node for the w1 gpio controller
>
> Maxime Ripard (5):
>   ARM: sun5i: chip: Enable Wi-Fi SDIO chip
>   ARM: sun5i: Rename A10s pins
>   ARM: sun5i: Add SPI2 pins
>   ARM: sun5i: Add RGB 565 LCD pins
>   ARM: sun5i: chip: Add optional buses
>
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  4 +-
>  arch/arm/boot/dts/sun5i-a10s.dtsi                |  4 +-
>  arch/arm/boot/dts/sun5i-r8-chip.dts              | 69 +++++++++++++++++-
>  arch/arm/boot/dts/sun5i.dtsi                     | 24 ++++++-
>  4 files changed, 97 insertions(+), 4 deletions(-)
>
> --
> git-series 0.8.10
