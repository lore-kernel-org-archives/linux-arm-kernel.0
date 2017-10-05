From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Oct 2017 13:43:15 +0200
Subject: [PATCH 6/8] pinctrl: meson: get rid of pin_base
In-Reply-To: <20170920133927.17390-7-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <20170920133927.17390-7-jbrunet@baylibre.com>
Message-ID: <CACRpkdYpWqVUSwkD9VeyztL7MxaffoKo8Cmh0_PkMuenLC2wTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 3:39 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> pin_base was used with the manually set pin offset in meson pinctrl. This
> is no longer the case, pin_base is 0 on every meson pinctrl controllers
> and should go away.
>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied.

Yours,
Linus Walleij
