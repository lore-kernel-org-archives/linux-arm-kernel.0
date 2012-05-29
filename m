From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 May 2012 09:51:37 +0800
Subject: [PATCH 06/16] ARM: ux500: Apply db8500-prcmu regulator
 information to db8500 Device Tree
In-Reply-To: <1337330355-17747-7-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdavjGoUn0D5L6TxTRfrC7RjwbAXscM6MJK8N7OxE68Mpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 4:39 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we inform Device Tree of which regulators are provided by the db8500-
> prcmu. This way we can reference some of their consumers directly from the
> Device Tree e.g. SMSC911x Ethernet chip and the Nomadik I2C controller.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Remove mentioning the I2C controller and
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
