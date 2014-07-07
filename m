From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 12:41:01 +0200
Subject: [PATCH 0/6] pinctrl: rockchip: support rk3288
In-Reply-To: <1887108.ECBDVhibgn@diego>
References: <1887108.ECBDVhibgn@diego>
Message-ID: <CACRpkdaG-FrfQOB0FHeev1D0L8rrOW2-4jW4KufJMb4NneVeHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 1:35 AM, Heiko St?bner <heiko@sntech.de> wrote:

> This series adds support for the rk3288 SoC.
>
> The first patch generalizes the gpio-only handling of the rk3188 into a
> general quirk-handling making it possible to deprecate the special bank
> compatible and also to add quirks of later SoCs.
>
> Patches 2 to 5 enable the driver to handle the quirks of rk3288 and
> patch 6 then simply adds the description of the rk3288 banks.
>
> Tested on a rk3288-evb and on a rk3188-radxarock with both the
> deprecated and new regular notation for bank0.
>
> Heiko Stuebner (6):
>   pinctrl: rockchip: generalize bank-quirks
>   pinctrl: rockchip: precalculate iomux offsets
>   pinctrl: rockchip: add support for 4bit wide iomux settings
>   pinctrl: rockchip: enable iomuxes from pmu space
>   pinctrl: rockchip: support unrouted iomuxes per bank
>   pinctrl: rockchip: add support for rk3288 pin-controller

Excellent and nice broken-down patch series Heiko!

All patches applied for v3.17.

Yours,
Linus Walleij
