From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 17:56:23 -0700
Subject: [PATCH v3 3/9] gpiolib: Use GPIO name from names array for gpio
 descriptor
In-Reply-To: <1439561466-14350-4-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-4-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdbYMOhuD+YLkEwRTU3kWjhkjEOmfkeu-_0U+C=PiOqbsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 7:11 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> This patch adds GPIO names to the GPIO descriptors when initializing the
> gpiochip. It also introduces a check whether any of the new names will
> conflict with an existing GPIO name.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Patch applied. To me this is the magic transition patch that make
things really smooth.

Yours,
Linus Walleij
