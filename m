From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Feb 2016 14:39:23 +0100
Subject: [PATCH v2] pinctrl: sunxi: H3 requires irq_read_needs_mux
In-Reply-To: <20160203075713.GA23312@box2.japko.eu>
References: <20160203075713.GA23312@box2.japko.eu>
Message-ID: <CACRpkdbVtLYRku03bbnT=f7Ex1FoJqBv4Z6nY7pWkHy6wvHUfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 8:57 AM, Krzysztof Adamski <k@japko.eu> wrote:

> It seems that on H3, just like on A10, when GPIOs are configured as
> external interrupt data registers does not contain their value.  When
> value is read, GPIO function must be temporary switched to input for
> reads.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

1. Waiting for Maxime's ACK on this patch.

2. Is this a regression that need to go in to fixes?

Yours,
Linus Walleij
