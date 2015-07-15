From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Jul 2015 06:34:12 -0700
Subject: [PATCH v1.1 1/4] ARM: dts: Add sbs-battery dts fragment used by
 chromebooks
In-Reply-To: <1731785.1QCGhpnXSY@diego>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
 <1436574562-16308-2-git-send-email-heiko@sntech.de>
 <1731785.1QCGhpnXSY@diego>
Message-ID: <CAD=FV=X+85xYLzNDYKaW47SdON9qQH0a5OiLxRfuuSP_ybGi=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jul 15, 2015 at 4:30 AM, Heiko St?bner <heiko@sntech.de> wrote:
> This patch creates a sbs-battery fragment for batteries connected
> to the i2c tunnel of the cros-ec embedded controller.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v1:
> - correct license
>
>  arch/arm/boot/dts/cros-ec-sbs.dtsi | 52 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Acked-by: Douglas Anderson <dianders@chromium.org>
