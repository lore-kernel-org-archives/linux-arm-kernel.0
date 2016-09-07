From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 01:09:29 +0200
Subject: [PATCH v2 3/4] pinctrl: sunxi: Remove unsupported PWM channel
 pinmux in H3
In-Reply-To: <20160831082520.25962-4-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-4-woogyom.kim@gmail.com>
Message-ID: <CACRpkda8uMuOi41O5Cq3o-PXynoZfkxAD7P2fHS-uCUQt_B_kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 10:25 AM, Milo Kim <woogyom.kim@gmail.com> wrote:

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

Patch applied with Chen-Yu's ACK.

Yours,
Linus Walleij
