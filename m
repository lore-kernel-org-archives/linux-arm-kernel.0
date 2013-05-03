From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:02:19 +0200
Subject: [PATCH 11/63] ARM: ux500: Strip out duplicate USB DMA
 configuration
In-Reply-To: <1367591569-32197-12-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ4ufprKp4P9p+Np-omi1on8BDTO0q9DONHtk7gGxczMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> For the moment at least, the TX and RX channels for DB8500 USB are
> identical, so this patch generalises them into a single structure
> and passes it twice. Once as the TX and again for the RX configuration.
> We're keeping the infrastructure the same i.e. passing the TX and RX
> separately in case they start to differ on latter incarnations of the
> platform.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied to my ux500-dma40 branch.

Thanks!
Linus Walleij
