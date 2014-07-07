From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 14:42:20 +0200
Subject: [PATCH] pinctrl: sunxi: Remove gpio_out function from sun5i-a13
 PG0/1/2 pins
In-Reply-To: <1404228308-22783-1-git-send-email-wens@csie.org>
References: <1404228308-22783-1-git-send-email-wens@csie.org>
Message-ID: <CACRpkdYAMktQYr6zS3b9Ku-L5oqApQFTx9Ov7LYqwexYbnh+Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 5:25 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The A13 user manual states pins PG0/1/2 only have GPIO input and
> interrupt functions. Remove the gpio_out functions for these pins.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
