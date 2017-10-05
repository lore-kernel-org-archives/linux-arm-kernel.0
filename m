From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Oct 2017 13:22:42 +0200
Subject: [PATCH 1/8] pinctrl: meson: remove offset from pinctrl
In-Reply-To: <20170920133927.17390-2-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <20170920133927.17390-2-jbrunet@baylibre.com>
Message-ID: <CACRpkdZJ6YWaMig2HSf6kf3aHHRmQ-ZdB0GhqF7f-EXX6iWLUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 3:39 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> Offset on meson pinctrl and gpios is something that was carried from the
> vendor driver, where there is a weird link between the 2
> controllers. Since these 2 controllers are independent, this offset adds
> an unnecessary complexity.
>
> This patch remove this manually set offset and rely on pinctrl to figure
> out the gpio base offset
>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied.

Yours,
Linus Walleij
