From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 14:29:35 +0100
Subject: [PATCH] pinctrl: sunxi: use chained_irq_{enter,
 exit} for GIC compatibility
In-Reply-To: <1392049357-13225-1-git-send-email-wens@csie.org>
References: <1392049357-13225-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdZXQMBTy4fW1R0pwSh40QJr=XkhwMp4nf_c0Rie16e0=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 5:22 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> On tha Allwinner A20 SoC, the external interrupts on the pin controller
> device are connected to the GIC. Without chained_irq_{enter, exit},
> external GPIO interrupts, such as used by mmc core card detect, cause
> the system to hang.
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied for fixes with Maxime's ACK.

Yours,
Linus Walleij
