From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 11:12:07 +0200
Subject: [PATCH 37/39] ARM: ux500: Stop passing DMA platform data though
 AUXDATA
In-Reply-To: <1368611522-9984-38-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-38-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ2-fBrjU-iofjq1DAJ96X2SqbjACsjEWYRxThnSm0yxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:52 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The DMA platform data is now empty due to some recent refactoring,
> so there is no longer a requirement to pass it though.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to dma40 branch, hm now I may get a conflict with all
the AUXDATA changes in the devicetree branch. Oh well, I'll
figure it out...

Yours,
Linus Walleij
