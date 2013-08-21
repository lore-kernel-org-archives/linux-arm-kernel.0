From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Aug 2013 23:46:53 +0200
Subject: [PATCHv3 4/9] pinctrl: sunxi: Add Allwinner A20 pins set
In-Reply-To: <1375610330-18185-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1375610330-18185-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375610330-18185-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdb8=wi4qQeNcnsvAZMUf0ja2t5rn9b=EeWSBc4fJ1+Wig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 4, 2013 at 11:58 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The Allwinner A20 is pin-compatible with the older A10, so the two pin
> set are quite similar. However, since the A20 has new features, we can't
> just use the A10 pin set as is, and we need to define our own for the
> A20.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Shall I apply this to the pinctrl tree?

Yours,
Linus Walleij
