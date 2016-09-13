From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2016 13:38:34 +0200
Subject: [PATCH v2 1/2] pinctrl: meson-gxbb: add the missing SDIO
 interrupt pin
In-Reply-To: <20160911123903.20027-2-martin.blumenstingl@googlemail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160911123903.20027-1-martin.blumenstingl@googlemail.com>
 <20160911123903.20027-2-martin.blumenstingl@googlemail.com>
Message-ID: <CACRpkdaRzbVuK2SPGLf9UwFJXq28iU3pRzo9ozaxAB-Nop9GKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 2:39 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> This adds the SDIO interrupt pin which can be used by sd_emmc_a.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Fixes: 29885a656511 ("pinctrl: meson-gxbb: add the pins for the
> SDIO/sd_emmc_a controller")

Patch applied with Kevin's ACK.

Yours,
Linus Walleij
