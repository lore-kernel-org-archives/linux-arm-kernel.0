From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 May 2012 10:02:01 +0200
Subject: [PATCH] SPI: PRIMA2: use the newest APIs of PINCTRL to fix
 compiling errors
In-Reply-To: <1337048460-30329-1-git-send-email-Barry.Song@csr.com>
References: <1337048460-30329-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdYPQW4cTh_j1y4u0wFKkQmgP3oR8E2SJXNSn68jt9pq7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 4:21 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> Fix the compiling errors:
> drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
> drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
> drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
> drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
> drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
> drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
> make[3]: *** [drivers/spi/spi-sirf.o] Error 1
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Counting on Grant to pick this up...

Yours,
Linus Walleij
