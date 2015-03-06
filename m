From: dianders@chromium.org (Doug Anderson)
Date: Fri, 6 Mar 2015 10:10:00 -0800
Subject: [PATCH 8/8] ARM: dts: rockchip: relicense rk3288-evb* under
 GPLv2/X11
In-Reply-To: <1425665046-22927-9-git-send-email-heiko@sntech.de>
References: <1425665046-22927-1-git-send-email-heiko@sntech.de>
 <1425665046-22927-9-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=WD69252+KGce_sri2D3M3sWGh+EPXePZv+RgVJun9VyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Mar 6, 2015 at 10:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> GPLv2-only devicetrees make reuse difficult for software components licensed
> under a different license.
>
> The consensus is that a GPL/X11 dual-license should allow all necessary uses,
> so relicense the rk3288-evb files to this combination.
>
> CCs were aquired by git shortlog -sne so it should've hopefully catched
> every contributor.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Roger Chen <roger.chen@rock-chips.com>
> Cc: Romain Perier <romain.perier@gmail.com>
> Cc: Caesar Wang <caesar.wang@rock-chips.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Yunzhi Li <lyz@rock-chips.com>
> ---
> I'm hoping to get Acked-by tags from the people in the Cc-list.
>
>  arch/arm/boot/dts/rk3288-evb-act8846.dts | 44 ++++++++++++++++++++++++++------
>  arch/arm/boot/dts/rk3288-evb-rk808.dts   | 44 ++++++++++++++++++++++++++------
>  arch/arm/boot/dts/rk3288-evb.dtsi        | 44 ++++++++++++++++++++++++++------
>  3 files changed, 108 insertions(+), 24 deletions(-)

I didn't read every word of the text, but dual licensing should be
fine from my point of view.

Acked-by: Doug Anderson <dianders@chromium.org>
