From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Nov 2015 13:01:47 -0800
Subject: [PATCH v2 6/8] ARM: dts: rockchip: add clock-cells for usb phy
 nodes
In-Reply-To: <1446998681-26436-7-git-send-email-heiko@sntech.de>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
 <1446998681-26436-7-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=UZzoUA626CE6tDW7jj+-5B7KLNHMfB+462pHpTQ_=fZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Sun, Nov 8, 2015 at 8:04 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Add the #clock-cells properties for the usbphy nodes as they
> provide the pll-clocks now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3066a.dtsi | 2 ++
>  arch/arm/boot/dts/rk3188.dtsi  | 2 ++
>  arch/arm/boot/dts/rk3288.dtsi  | 3 +++
>  3 files changed, 7 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
