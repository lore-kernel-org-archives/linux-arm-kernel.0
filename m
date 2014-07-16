From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Jul 2014 13:04:46 -0700
Subject: [PATCH 5/6] ARM: dts: rockchip: add core rk3288 dtsi
In-Reply-To: <1868508.hOA6VOBqnH@diego>
References: <1471578.ILeMmG2DL6@diego>
	<1868508.hOA6VOBqnH@diego>
Message-ID: <CAD=FV=Wqt+psd52rdbag7tKg4Cj1h-Mtp=fZzJ04sKT2qG4WHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 15, 2014 at 4:02 PM, Heiko St?bner <heiko@sntech.de> wrote:
> +                       i2c0 {
> +                               i2c0_xfer: i2c0-xfer {
> +                                       rockchip,pins = <0 15 RK_FUNC_1 &pcfg_pull_none>,
> +                                                       <0 16 RK_FUNC_1 &pcfg_pull_none>;
> +                               };
> +                       };
> +
> +                       i2c1 {
> +                               i2c1_xfer: i2c1-xfer {
> +                                       rockchip,pins = <8 4 RK_FUNC_1 &pcfg_pull_none>,
> +                                                       <8 5 RK_FUNC_1 &pcfg_pull_none>;
> +                               };
> +                       };
> +
> +                       i2c2 {
> +                               i2c2_xfer: i2c2-xfer {
> +                                       rockchip,pins = <6 9 RK_FUNC_1 &pcfg_pull_none>,
> +                                                       <6 10 RK_FUNC_1 &pcfg_pull_none>;
> +                               };
> +                       };
> +
> +                       i2c3 {
> +                               i2c3_xfer: i2c3-xfer {
> +                                       rockchip,pins = <2 16 RK_FUNC_1 &pcfg_pull_none>,
> +                                                       <2 17 RK_FUNC_1 &pcfg_pull_none>;
> +                               };
> +                       };
> +
> +                       i2c4 {
> +                               i2c4_xfer: i2c4-xfer {
> +                                       rockchip,pins = <7 17 RK_FUNC_1 &pcfg_pull_none>,
> +                                                       <7 18 RK_FUNC_1 &pcfg_pull_none>;
> +                               };
> +                       };
> +
> +                       i2c5 {
> +                               i2c5_xfer: i2c5-xfer {
> +                                       rockchip,pins = <7 19 RK_FUNC_1 &pcfg_pull_none>,
> +                                                       <7 20 RK_FUNC_1 &pcfg_pull_none>;
> +                               };
> +                       };

Since there's a strong concept of numbering of i2c busses on this SoC,
could you add aliases so that they show up nicely with the right ID?

Thanks!

-Doug
