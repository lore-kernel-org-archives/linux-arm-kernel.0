From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Oct 2017 13:45:26 +0200
Subject: [PATCH 8/8] pinctrl: meson-gxbb: add missing GPIOX_22 pin
In-Reply-To: <20170920133927.17390-9-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <20170920133927.17390-9-jbrunet@baylibre.com>
Message-ID: <CACRpkdaiGrR3BOewWOK=VMPEe4QdVeSJVfP9jKi7-RKG9W95=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 3:39 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> GPIOX_22 is declared as a gpio but the id is no present in the pin
> table. This hole trigger an error while reading the pingroup debugfs entry
>
> GPIOX_22 is no routed externally. For all we know, it could an internal
> pin of SoC
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied.

Yours,
Linus Walleij
