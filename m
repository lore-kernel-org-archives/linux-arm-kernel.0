From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Dec 2012 21:44:08 +0100
Subject: [PATCH] pinctrl: sirf: enable GPIO pullup/down configuration from
 dts
In-Reply-To: <1355476559-27550-1-git-send-email-Barry.Song@csr.com>
References: <1355476559-27550-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdZ4_8OiXWJ3WWggXOMyu+mAsBWiMEz4V9-xZYVnL=qyTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 10:15 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> commit 7bec207427c2efb794 remove sirfsoc_gpio_set_pull function,
> this patches takes the feature back by adding sirf,pullups and
> sirf,pulldowns prop in dts, and the driver will set the GPIO
> pull according to the dts.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Applied, thanks.

Yours,
Linus Walleij
