From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Jun 2011 19:46:26 +0200
Subject: [PATCH] mach-ux500: fix USB build error
In-Reply-To: <1309191570-3978-1-git-send-email-linus.walleij@stericsson.com>
References: <1309191570-3978-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201106271946.26257.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 June 2011 18:19:30 Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The mach-ux500/usb.c was referencing DMA macros, but not
> including <linux/dma-mapping.h> so it didn't compile. Fixed by
> a proper #include.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied.

Thanks,

	Arnd
