From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 Oct 2017 08:34:25 -0700
Subject: [RESEND PATCH 0/2] rockchip: kevin: Enable edp display
In-Reply-To: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
Message-ID: <CAD=FV=XieqJoXfurJZwayOmCSanaPr-4e2mp0g8Zf4pc_Tc0yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 13, 2017 at 3:41 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>
> Make edp display works on chromebook kevin.
>
>
> Jeffy Chen (2):
>   spi: rockchip: Convert to late and early system PM callbacks
>   arm64: dts: rockchip: Enable edp disaplay on kevin
>
>  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 29 +++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 16 +++++++++++++
>  drivers/spi/spi-rockchip.c                        |  2 +-
>  3 files changed, 46 insertions(+), 1 deletion(-)

Presumably including Sean Paul would be a wise idea on future patches
trying to make eDP work well upstream since he's worked on supporting
rk3399 eDP in the past.  I think Alexandru has also expressed interest
in this area, too.

-Doug
