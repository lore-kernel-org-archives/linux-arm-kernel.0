From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Oct 2014 14:24:23 +0200
Subject: [PATCH v5 3/4] ARM: dts: vf610: use new GPIO support
In-Reply-To: <150ed46ff5102dc0fc8bd81160387cfeee748a27.1413488264.git.stefan@agner.ch>
References: <cover.1413488264.git.stefan@agner.ch>
 <150ed46ff5102dc0fc8bd81160387cfeee748a27.1413488264.git.stefan@agner.ch>
Message-ID: <CACRpkdYBBucVNeG7kAjZdqnKYTk6ZCcHa6aBrtgBL+h5AoWNvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 9:47 PM, Stefan Agner <stefan@agner.ch> wrote:

> Use GPIO support by adding SD card detection configuration and
> GPIO pinmux for Colibri's standard GPIO pins. Attach the GPIO
> pins to the iomuxc node to get the GPIO pin settings applied.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please take this through whatever platform tree funnels those DTS
patches.

Yours,
Linus Walleij
