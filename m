From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 14:29:05 +0100
Subject: [PATCH v2 1/2] pinctrl: meson-axg: Introduce a pinctrl pinmux ops
 for Meson-AXG SoC
In-Reply-To: <20171120100825.16613-2-yixun.lan@amlogic.com>
References: <20171120100825.16613-1-yixun.lan@amlogic.com>
 <20171120100825.16613-2-yixun.lan@amlogic.com>
Message-ID: <CACRpkdYVWz2Wy5M+QKY=xj8v2EiLotpKHwBpVkA5+CQMvYARDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 11:08 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> The pin controller has been updated in the Amlogic Meson AXG series,
> which use continuous 4-bit register to select function for each pin.
> In order to support this, a new pinmux operations "meson_axg_pmx_ops"
> has been added.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
