From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 00:23:39 +0100
Subject: [PATCH v2 5/5] gpio: allow setting ARCH_NR_GPIOS from Kconfig
In-Reply-To: <1455637261-2920972-5-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-5-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdaSxhBrSt5qcUUJPcN6nv9Go96TP52cyU_nBZZM0phuPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ARM version of asm/gpio.h basically just contains the same definitions
> as the gpiolib version, with the exception of ARCH_NR_GPIOS.
>
> This adds the option for overriding the constant through Kconfig to
> the architecture-independent header, so we can remove the ARM specific
> file later.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
