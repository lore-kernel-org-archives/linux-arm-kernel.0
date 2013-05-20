From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:09:11 +0200
Subject: [PATCH 14/39] ARM: ux500: Stop passing Hash DMA channel config
 information though pdata
In-Reply-To: <1368611522-9984-15-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZWtm_6WD=ifYLH5QogzrCyHHuhJ4xHzAjiTWX_fYAKcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA channel configuration information should be setup in the driver.
> The Ux500 Hash driver now does this, so there's no need to send it
> though here too.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied now that the deps are in!

Yours,
Linus Walleij
