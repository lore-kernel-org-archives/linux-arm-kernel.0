From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 14:08:31 +0200
Subject: [PATCH 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <1439979512-3894-4-git-send-email-mpa@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
 <1439979512-3894-4-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZV0_QgT9eAPC7cQ4JFYb5npNobn40M13mhYruU0O0vdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:18 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> From: Markus Pargmann <mpa@devmp.org>
>
> This functions adds a way to initialize a GPIO without hogging it.
>
> Signed-off-by: Markus Pargmann <mpa@devmp.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio.txt | 29 +++++++------

This needs to go to devicetree at vger.kernel.org for review.

Yours,
Linus Walleij
