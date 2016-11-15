From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Nov 2016 10:16:52 +0100
Subject: [PATCH v2 1/3] pinctrl: sunxi: Fix PIN_CONFIG_BIAS_PULL_{DOWN,
 UP} argument
In-Reply-To: <20161111024455.16883-2-wens@csie.org>
References: <20161111024455.16883-1-wens@csie.org>
 <20161111024455.16883-2-wens@csie.org>
Message-ID: <CACRpkdb0dqxzQOnChj_SG1-8Hi4ezt+vWaMQ6kr5+YReDop3vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 3:44 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> According to pinconf-generic.h, the argument for
> PIN_CONFIG_BIAS_PULL_{DOWN,UP} is non-zero if the bias is enabled
> with a pull up/down resistor, zero if it is directly connected
> to VDD or ground.
>
> Since Allwinner hardware uses a weak pull resistor internally,
> the argument should be 1.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
