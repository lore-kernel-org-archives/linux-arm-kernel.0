From: dianders@chromium.org (Doug Anderson)
Date: Fri, 6 Mar 2015 10:11:02 -0800
Subject: [PATCH 4/8] ARM: dts: rockchip: relicense rk3288.dtsi under
 GPLv2/X11
In-Reply-To: <1425665046-22927-5-git-send-email-heiko@sntech.de>
References: <1425665046-22927-1-git-send-email-heiko@sntech.de>
 <1425665046-22927-5-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=VCqwYiBQbr0=j9=PsZxse69E5MF1Bi24gMCv530Ht49g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Mar 6, 2015 at 10:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> GPLv2-only devicetrees make reuse difficult for software components licensed
> under a different license.
>
> The consensus is that a GPL/X11 dual-license should allow all necessary uses,
> so relicense the rk3288.dtsi to this combination.
>
> CCs were aquired by git shortlog -sne so it should've hopefully catched
> every contributor.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Addy Ke <addy.ke@rock-chips.com>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Caesar Wang <caesar.wang@rock-chips.com>
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Jianqun Xu<jay.xu@rock-chips.com>
> Cc: Roger Chen <roger.chen@rock-chips.com>
> Cc: Sonny Rao <sonnyrao@chromium.org>
> Cc: Yunzhi Li <lyz@rock-chips.com>
> Cc: huang lin <hl@rock-chips.com>
>
> Not sure if an Ack for a simple revert is necessary, but included anyway
> Cc: Olof Johansson <olof@lixom.net>
> ---
> I'm hoping to get Acked-by tags from the people in the Cc-list.
>
>  arch/arm/boot/dts/rk3288.dtsi | 44 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)

I didn't read every word of the text, but dual licensing should be
fine from my point of view.

Acked-by: Doug Anderson <dianders@chromium.org>
