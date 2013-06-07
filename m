From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Jun 2013 11:15:38 +0200
Subject: [PATCH v2 3/6] clk: divider: add CLK_DIVIDER_HIWORD_MASK flag
In-Reply-To: <1370358317-12768-4-git-send-email-haojian.zhuang@linaro.org>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
 <1370358317-12768-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZJmUQPiZrkzpNP2kc=3opDtwju5W1i4Z8wtYBbbmnidQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 5:05 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> In Hisilicon Hi3620 clock divider register, 16-bit HIWORD is mask field.
> Support the HIWORD mask to reuse clock divider driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

I don't understand this...

> + * CLK_DIVIDER_HIWORD_MASK - register contains high 16-bit as mask field

Could you be a bit more verbose here on what this actually means,
so other users of this flag will realize if they need to set it?

In other cases in the clk subsystem where masks and shifts are
used, the position and number of bits are stated, rather than a
single flag indicating some 16 bits.

Yours,
Linus Walleij
