From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 Aug 2016 16:35:07 +0800
Subject: [PATCH v2 3/4] pinctrl: sunxi: Remove unsupported PWM channel
 pinmux in H3
In-Reply-To: <20160831082520.25962-4-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-4-woogyom.kim@gmail.com>
Message-ID: <CAGb2v66+oQxCKFuA1yMSW_N90VPu6GOdFXKUfO3DC6_u3JAfNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 4:25 PM, Milo Kim <woogyom.kim@gmail.com> wrote:
> H3 has single PWM channel. The second PWM channel is not supported,
> so the pinctrl function should be removed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Cc: Jens Kuske <jenskuske@gmail.com>
> Cc: Krzysztof Adamski <k@japko.eu>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
