From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 May 2017 11:35:53 +0200
Subject: [PATCH 2/3] gpio: pcf857x: move header file out of I2C realm
In-Reply-To: <20170521215727.1243-3-wsa@the-dreams.de>
References: <20170521215727.1243-1-wsa@the-dreams.de>
 <20170521215727.1243-3-wsa@the-dreams.de>
Message-ID: <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
>  arch/arm/mach-pxa/balloon3.c                   | 2 +-
>  arch/arm/mach-pxa/stargate2.c                  | 2 +-
>  arch/mips/ath79/mach-pb44.c                    | 2 +-
>  drivers/gpio/gpio-pcf857x.c                    | 2 +-
>  include/linux/{i2c => platform_data}/pcf857x.h | 0
>  8 files changed, 7 insertions(+), 7 deletions(-)
>  rename include/linux/{i2c => platform_data}/pcf857x.h (100%)

Patch applied.

BTW ARM SoC maintainers be warned, I optimistically assume this will
not collide with any ARM SoC work...

Yours,
Linus Walleij
