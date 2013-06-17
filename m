From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 13:22:30 +0200
Subject: [PATCH] spi: pl022: remove unused ret and pins_state variables
In-Reply-To: <1371463695-21252-1-git-send-email-fabio.baltieri@linaro.org>
References: <1371463695-21252-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdb_AKomxOQA_tN4kev8v5paPtm_M5WGR+drhO6n37AKKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 12:08 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Removes the warnings:
>
> drivers/spi/spi-pl022.c: In function 'pl022_suspend_resources':
> drivers/spi/spi-pl022.c:2322:24: warning: unused variable 'pins_state' [-Wunused-variable]
> drivers/spi/spi-pl022.c:2321:6: warning: unused variable 'ret' [-Wunused-variable]
> drivers/spi/spi-pl022.c: In function 'pl022_resume_resources':
> drivers/spi/spi-pl022.c:2334:6: warning: unused variable 'ret' [-Wunused-variable]
>
> introduced in:
>
> f1c9cf0 spi: pl022: use pinctrl PM helpers
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

How sloppy of me. Applied with Mark's ACK.

Thanks!
Linus Walleij
