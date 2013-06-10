From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 14:55:41 +0200
Subject: [EXAMPLE PATCH] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <201306090201.17739.heiko@sntech.de>
References: <201306090159.05383.heiko@sntech.de>
 <201306090201.17739.heiko@sntech.de>
Message-ID: <CACRpkdbiHRrP7Xun1sPJ+o45Hofp3gCe89GY0fFiuF1F7TUaxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 2:01 AM, Heiko St?bner <heiko@sntech.de> wrote:

> This driver adds support the Cortex-A9 based SoCs from Rockchip,
> so at least the RK2928, RK3066 (a and b) and RK3188.
> Earlier Rockchip SoCs seem to use similar mechanics for gpio
> handling so should be supportable with relative small changes.
> Pull handling on the rk3188 is currently a stub, due to it being
> a bit different to the earlier SoCs.
>
> Pinmuxing as well as gpio (and interrupt-) handling tested on
> a rk3066a based machine.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

You've been super-helpful, so of course I'm happy to merge this
into the pinctrl tree.

Yours,
Linus Walleij
