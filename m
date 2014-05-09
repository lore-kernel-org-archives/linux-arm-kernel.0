From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 May 2014 11:18:09 +0200
Subject: [PATCH v2 8/8] ARM: dts: rockchip: convert pinctrl nodes to new
 bindings
In-Reply-To: <1719309.HLoKcrQoNG@diego>
References: <11862890.WUjscWaP3U@diego>
	<1719309.HLoKcrQoNG@diego>
Message-ID: <CACRpkdbHMcDMX-1rrgiv1ibwTFHUMTxRiOhdoSAQwa4T5QCWgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 2:00 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Introduce the grf syscon and convert the pinctrl drivers for rk3066 and rk3188
> to use it, instead of mapping the grf registers themselfs.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Max Schwarz <max.schwarz@online.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through the ARM SoC tree with the rest of the
Rockchip changes for v3.16. (I'll take patches 1-7.)

Yours,
Linus Walleij
