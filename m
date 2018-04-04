From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 4 Apr 2018 14:46:27 +0200
Subject: [PATCH 0/3] mmc: meson-axg: initial support for AXG SoC platform
In-Reply-To: <20180403100652.41056-1-yixun.lan@amlogic.com>
References: <20180403100652.41056-1-yixun.lan@amlogic.com>
Message-ID: <CAPDyKFpf=Mzryr6wijndKt4Hx48nSGSzyysqAABRGu8_vzGj6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2018 at 12:06, Yixun Lan <yixun.lan@amlogic.com> wrote:
>    The patches series try to enable basic eMMC support in the Meson-AXG platfrom.
>
>    Currently HS200 mode is tested with clock running at 166MHz, since
> not all boards are stable to running 200MHz (due to tuning phase error),
> we will further improve the tuning phase driver in the future,
> but in my opiton, this patch series itself is pretty good to go.
>
> Nan Li (3):
>   mmc: dt-bindings: update bindings doc to support Meson-AXG SoC
>   mmc: meson-axg: add support for the Meson-AXG platform
>   mmc: meson: update doc to support Meson-AXG platform
>
>  .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  1 +
>  drivers/mmc/host/Kconfig                           |  4 +-
>  drivers/mmc/host/meson-gx-mmc.c                    | 63 ++++++++++++++++++----
>  3 files changed, 55 insertions(+), 13 deletions(-)
>
> --
> 2.16.2
>

Queued up for 3.18, thanks!

Kind regards
Uffe
