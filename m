From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2018 10:28:49 +0100
Subject: [PATCH] pinctrl: meson-gxl: remove invalid GPIOX tsin_a pins
In-Reply-To: <1541587358-17654-1-git-send-email-narmstrong@baylibre.com>
References: <1541587358-17654-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdYpk1Mts9SxQq5nAdBBcWyZJouYgwR6uQaKMOe8o6u=OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 11:42 AM Neil Armstrong <narmstrong@baylibre.com> wrote:

> The GPIOX tsin_a pins wrongly uses the SDCard pinctrl bits, this
> patch completely removes these pins entries until we find out what
> are the correct bits and registers to be used instead.
>
> Fixes: 5a6ae9b80139 ("pinctrl: meson-gxl: add tsin_a pins")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied.
It doesn't look like a regression so I only applied it for
next (v4.21).

Yours,
Linus Walleij
