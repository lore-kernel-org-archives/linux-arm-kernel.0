From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 10:57:09 +0200
Subject: [PATCH 1/5] pinctrl: meson-gxl: Fix typo in AO I2S pins
In-Reply-To: <1495614042-2676-2-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
 <1495614042-2676-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdYgzu052VFYCv6vQ0g2dLOS5Nz=DbV0iwRQuJLdjLbMtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 10:20 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:

> The AO I2S pins were incorrectly defined with the EE pin offset.
>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Fixes: 2899adf0422 ("pinctrl: meson: gxl: add i2s output pins")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied with Jerome's review tag.

Yours,
Linus Walleij
