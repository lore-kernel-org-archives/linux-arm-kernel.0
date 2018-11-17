From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Nov 2018 13:19:16 +0100
Subject: [PATCH 2/2] pinctrl: rockchip: add rk3188 routes to switch
 between nand and emmc
In-Reply-To: <20181111210047.30375-2-heiko@sntech.de>
References: <20181111210047.30375-1-heiko@sntech.de>
 <20181111210047.30375-2-heiko@sntech.de>
Message-ID: <CACRpkdZO852hScSgCGQVspcLSCK99B5ofM9mNkGUj-uQHwfS+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2018 at 10:01 PM Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@bq.com>
>
> The rk3188 has pins that are not handled through the regular iomuxing
> for handling either nand-flash or an emmc and are set through only one
> specifal setting. So utilize the routing function to simply do that
> setting depending on one of the core nand/emmc signals that are actually
> regular pins handled through pinctrl.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Patch applied.

Yours,
Linus Walleij
