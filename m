From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Aug 2018 19:10:22 +0200
Subject: [PATCH 0/5] pinctrl: meson: Add support for TEST_N gpio
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdbSE0ThGpEo2YnVQ7wW85QbAeOwmFpLczHwL3Q2W3ZF6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2018 at 12:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

> The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> set the TEST_N pin direction.
> This patchset :
> - adds the Secure Monitor call
> - adds support int the pinctrl-meson common code
> - adds support for GXBB, GXL and AGX SoCs

A lot of trouble to access a single GPIO pin (I guess _N means "active low"?)

Is this line used for something especially important? Would be nice to
include in some commit message like patch 1/5 why we invest so much
energy to accessing this pin.

Just curious. If you're just aiming for feature completion, that is a good
reason as well :D

Yours,
Linus Walleij
