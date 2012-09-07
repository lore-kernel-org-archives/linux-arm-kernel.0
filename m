From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 23:07:33 +0200
Subject: [PATCH 5/7] gpio: 74x164: Add support for the daisy-chaining
In-Reply-To: <1347020296-18796-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347020296-18796-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkda9QHBQN-6fuAu27OdVN0JySdDd3H+L3rhs_UuJfnb7bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 2:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The shift registers have an output pin that, when enabled, propagates
> the values of its internal register to the pins. If another value comes
> to the register while the output pin is disabled, this new value will
> makae the older shift into the next register in the chain.
>
> This patch adds support for daisy-chaining the registers, using the
> regular SPI chip select mechanism to manage the output pin, and the
> registers-number dt property to set the number of chained registers.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I'm stalling 5 thru 7 waiting for Florians comments to be addressed.

Yours,
Linus Walleij
