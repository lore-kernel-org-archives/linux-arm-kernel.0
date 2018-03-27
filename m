From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 13:37:08 +0200
Subject: [PATCH] pinctrl: uniphier: divide I2S and S/PDIF audio out
 pin-mux group
In-Reply-To: <20180314063535.13303-1-suzuki.katsuhiro@socionext.com>
References: <20180314063535.13303-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CACRpkdYDJkk8eJuGPAXO7fpvGZ4KbjSf43difeEGTV9KzJcmvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 7:35 AM, Katsuhiro Suzuki
<suzuki.katsuhiro@socionext.com> wrote:

> This patch divides large pin-mux group 'aio' of UniPhier LD11/LD20
> to 2 groups as following:
>   aout1   : 8ch I2S output: AO1DACCK, AO1BCK, AO1LRCK, AO1D[0-2]
>   aoutiec1: S/PDIF output : AO1IEC, AO1ARC
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Patch applied with Masahiro's ACK!

Yours,
Linus Walleij
