From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 15:46:53 +0200
Subject: [PATCH] pinctrl: at91: add support for OUTPUT config
In-Reply-To: <1377615082-16808-1-git-send-email-b.brezillon@overkiz.com>
References: <1377615082-16808-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACRpkdbkp-aqYWO=jkBvCT0U3wbKJMBfk2N17cUZeM5rfZiU5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 4:51 PM, Boris BREZILLON
<b.brezillon@overkiz.com> wrote:

> Add support for pin output control through the pinctrl config:
>  - support enabling/disabling output on a given pin
>  - support output level setting (high or low)
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

NAK.

We already have this:

 * @PIN_CONFIG_OUTPUT: this will configure the pin in output, use argument
 *      1 to indicate high level, argument 0 to indicate low level.

It also has device tree bindings:

output-low              - set the pin to output mode with low level
output-high             - set the pin to output mode with high level

Yours,
Linus Walleij
