From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Mar 2017 11:40:57 +0200
Subject: [RFT PATCH 5/6] pinctrl: meson: use gpio-ranges from DT
In-Reply-To: <1490286449-19448-6-git-send-email-narmstrong@baylibre.com>
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
 <1490286449-19448-6-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdYuj8-q-LbKYCH7dfLzF_10oViLwF3rjxULgmuw6AXYRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 5:27 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> When trying to add a gpio-hog, we enter a weird loop where the gpio-ranges
> is needed when gpiochip_add_data() is called but in the current implementation
> the ranges are added from the driver afterwards.
>
> A simple solution is to rely on the DR gpio-ranges attribute and remove the
> call to gpiochip_add_pin_range().
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied.

Yours,
Linus Walleij
