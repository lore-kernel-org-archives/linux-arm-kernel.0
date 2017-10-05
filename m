From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:51:02 +0800
Subject: [PATCH 13/20] ARM: dts: sun4i: Remove gpio-keys warnings
In-Reply-To: <247d527cb833713f487b97a2c95e30545273ac92.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <247d527cb833713f487b97a2c95e30545273ac92.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64df+tQnM1W=KDWNXsnRhEVo2hsTB1YJsPJkzvgw8J1ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some gpio-keys definitions in our DTs were having buttons defined with a
> unit-address and that would generate a DTC warning.
>
> Change the buttons node names to remove the warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 40 ++++++++++-----------
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts      |  6 +--
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> index 7c7f12132ea3..13224f5ac166 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> @@ -67,7 +67,7 @@
>                 #size-cells = <0>;
>                 poll-interval = <20>;
>
> -               button at 0 {
> +               left-joystick-left {

Does this fit the naming scheme? Should we have "-button" suffices?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
