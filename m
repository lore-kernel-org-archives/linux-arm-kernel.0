From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 23:17:47 -0600
Subject: [PATCH] SPI: PRIMA2: use the newest APIs of PINCTRL to fix
 compiling errors
In-Reply-To: <CACRpkdYPQW4cTh_j1y4u0wFKkQmgP3oR8E2SJXNSn68jt9pq7g@mail.gmail.com>
References: <1337048460-30329-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdYPQW4cTh_j1y4u0wFKkQmgP3oR8E2SJXNSn68jt9pq7g@mail.gmail.com>
Message-ID: <20120520051747.7744B3E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012 10:02:01 +0200, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, May 15, 2012 at 4:21 AM, Barry Song <Barry.Song@csr.com> wrote:
> 
> > From: Barry Song <Baohua.Song@csr.com>
> >
> > Fix the compiling errors:
> > drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
> > drivers/spi/spi-sirf.c:563: error: implicit declaration of function 'pinmux_get'
> > drivers/spi/spi-sirf.c:563: warning: assignment makes pointer from integer without a cast
> > drivers/spi/spi-sirf.c:568: error: implicit declaration of function 'pinmux_enable'
> > drivers/spi/spi-sirf.c:602: error: implicit declaration of function 'pinmux_disable'
> > drivers/spi/spi-sirf.c:603: error: implicit declaration of function 'pinmux_put'
> > make[3]: *** [drivers/spi/spi-sirf.o] Error 1
> >
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Counting on Grant to pick this up...

Applied, thanks.

g.
