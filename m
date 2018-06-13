From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jun 2018 11:07:49 +0200
Subject: [PATCH 1/3] rtc: ftrtc010: switch to devm_rtc_allocate_device
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
Message-ID: <CACRpkdZkXQj9xxN-wBjT_Y4Q5Se-Ts488bZzunYyecTau1pOEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Switch to devm_rtc_allocate_device/rtc_register_device. This allow or
> further improvement and simplifies ftrtc010_rtc_remove().
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
