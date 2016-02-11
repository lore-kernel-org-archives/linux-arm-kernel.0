From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Feb 2016 13:01:32 +0100
Subject: [PATCH] pinctrl: sunxi: H3 requires irq_read_needs_mux
In-Reply-To: <20160202100217.GA7483@box2.japko.eu>
References: <20160202100217.GA7483@box2.japko.eu>
Message-ID: <CACRpkdbp2J5eVwsJpuyxkjv72mB4ojcauXoDn1_iei7XB0yzxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 11:03 AM, Krzysztof Adamski
<krzysztof.adamski@sonymobile.com> wrote:

> It seems that on H3, just like on A10, when GPIOs are configured as
> external interrupt data registers does not contain their value.  When
> value is read, GPIO function must be temporary switched to input for
> reads.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

Patch applied for fixes with Maxime's ACK.

Yours,
Linus Walleij
