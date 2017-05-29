From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 10:58:14 +0200
Subject: [PATCH 2/5] pinctrl: meson-gxl: Fix typo in AO SPDIF pins
In-Reply-To: <1495614042-2676-3-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
 <1495614042-2676-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdZUr_swQx9oUrxQRHk+bFvdux1TgumQEmtiVg69T5XjaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 10:20 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:

> The AO SPDIF pins were incorrectly defined with the EE pin offset.
>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Fixes: b840d649f9ec ("pinctrl: meson: gxl: add spdif output pins")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied with Jerome's review tag.

Yours,
Linus Walleij
