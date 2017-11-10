From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Nov 2017 11:40:52 +0100
Subject: [PATCH] pinctrl: samsung/s3c24xx: add CONFIG_OF dependency
In-Reply-To: <20171107141244.3377780-1-arnd@arndb.de>
References: <20171107141244.3377780-1-arnd@arndb.de>
Message-ID: <CACRpkdbSPqATnL_ROFM2VtCYcBPyybxxmnyQbn6bohDeFYa09g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 3:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The driver fails to build without CONFIG_OF:
>
> drivers/pinctrl/samsung/pinctrl-samsung.c: In function 'samsung_gpiolib_register':
> drivers/pinctrl/samsung/pinctrl-samsung.c:936:5: error: 'struct gpio_chip' has no member named 'of_node'
>
> This configuration is now possible since we can now select the
> PINCTRL subsystem on S3C24xx machines other than the device tree
> based ones.
>
> Fixes: d219b924611a ("pinctrl: change Kconfig PINCTRL variable to a menuconfig")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied!

Yours,
Linus Walleij
